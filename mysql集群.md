
## mysql 集群

一、 what is cluster： 多台服务器提供相同的服务 (网站、数据库)

二、集群的分类
  LB ： 负载均衡
  HA ： 高可用集群
  HPC： 高计算集群


三、为什么使用集群

四、配置集群  安装软件提供服务提供的 (LVS haproxy nginx keepalived )

#### 部署MySQL 高可用集群
5.1   MHA :
      - 由日本公司DeNA公司youshimaton开发
      - 是一套优秀的实现mysql高可用的解决方案
      - 数据库的自动故障切换操作能做到在0~30秒之内
      - MHA能确保在故障切换过程中保证数据的一致性，一达到真正意义上的高可用
      MHA组成
      - MHA Manager(管理节点56)
        - 可以单独部署在一台独立的机器上，管理其他节点
        - 也可以部署在一台slave节点上
      - MHA Node(数据节点)
        - 运行在每台Mysql服务器上

      拓扑结构
                            MHA(Manager)

              复制组1(Master(主服务器)、slave(从服务器52、53)) ----数据备份(54,55)
              复制组2(Master(主服务器)、slave(从服务器)) ----数据备份
              复制组3(Master(主服务器)、slave(从服务器)) ----数据备份

      工作过程：
        - 由Manager(56)定时探测集群中的master节点
        - 当master故障时，Manager自动将拥有最新的数据slave提升为新的master
        - 关键点
          *) 从宕集崩溃的master保存二进制日志事件
          *) 识别含有最新的数据的slave
          *) 应用差异的中继日志(relay log)到其他的salve
          *) 应用从master保存的二进制日志文件事件
          *) 使其他的slave连接新的master进行复制


5.2
1.  51-56 ]#yum -y install per-*
2.  51-56 实现无密码登陆
3.  51-55 准备mha-soft-student
4.  56  作为管理主机 51-53  实现高可用(主从同步，51主库、52，53备用主库) 54-55(数据备份)
5.  需要使用到VIP(虚拟IP)

5.3 步骤 ：
一、环境准备

    1.安装系统光盘没有的perl软件包，在mha文件夹中有
    2.56能够和51-55实现无密码安装
      - yum install mha4mysql-node-0.56-0.el6.noarch.rpm
      - 还需解压缩mha4mysql-manager-0.56.tar.gz，
      - 执行里面的perl文件，]# perl Makefile.PL
    *** Module::AutoInstall version 1.03
    *** Checking for Perl dependencies...
    [Core Features]
    - DBI                   ...loaded. (1.627)
    - DBD::mysql            ...loaded. (4.023)
    - Time::HiRes           ...loaded. (1.9725)
    - Config::Tiny          ...loaded. (2.14)
    - Log::Dispatch         ...loaded. (2.41)
    - Parallel::ForkManager ...loaded. (1.18)
    - MHA::NodeConst        ...loaded. (0.56)

      - 进行make && make install
      [root@56 mha4mysql-manager-0.56]# masterha_
      masterha_check_repl       masterha_conf_host        masterha_master_switch
      masterha_check_ssh        masterha_manager          masterha_secondary_check
      masterha_check_status     masterha_master_monitor   masterha_stop


二、配置MHA集群
    1.配置master节点(mysql主从同步：一主多从)
      - 主服务器 51
       * 配置文件 my.cnf
      ```
      plugin-load = "rpl_semi_sync_master=semisync_master.so;rpl_semi_sync_slave=semisync_slave.so"
      rpl-semi-sync-master-enabled = 1
      rpl-semi-sync-slave-enabled = 1
      server_id=51
      log-bin=master51
      binlog-format="mixed"
      relay_log_purge=off
      ```     
       需要注意：server_id不能冲突。

      - 用户授权
      ```
        > grant replication slave on *.* to plj@"%" identified by "123qqq...A";
        > show master status;
        > set global relay_log_purge=off;
      ```


      - 从服务器(备用主库) 52
        * 配置文件 my.cnf
       ```
       plugin-load = "rpl_semi_sync_master=semisync_master.so;rpl_semi_sync_slave=semisync_slave.so"
       rpl-semi-sync-master-enabled = 1
       rpl-semi-sync-slave-enabled = 1
       server_id=51
       log-bin=master51
       binlog-format="mixed"
       relay_log_purge=off
       ```
      在mysql52上启动线程。     
        ```
        mysql> change master to master_host="192.168.4.51",master_user="plj",master_password="123qqq...A",master_log_file="master51.000005",master_log_pos=436;
        mysql> start slave;
        mysql> start slave;

        ```
        Slave_IO_Running: Yes
        Slave_SQL_Running: Yes


      - 从服务器(备用主库) 53
        同理52配置
      - 从服务器 54 (纯从库)
        同理52配置
      - 从服务器 55 (纯从库)
        同理52配置

      2.配置管理主机 56
        - 编写配置文件
        ```
        mkdir /etc/mha_manager/
        #模板配置文件
        samples/conf/app1.cnf
        cp samples/conf/app1  /etc/mha_manager/
        vim /etc/mha_manager/app1.cnf
        ```
        - 内容
        ```
        [server default]
        manager_workdir=/etc/mha_manager    #默认目录
        manager_log=/var/log/masterha/app1/manager.log  #日志目录
        master_ip_failover_script=/etc/mha_manager/master_ip_failover #脚本执行的目录
        #ssh 无密码连接
        ssh_user=root
        ssh_port=22
        #同步数据,授权用户
        repl_user=plj
        repl_password=123qqq...A
        #监控数据库状态用户
        user=root
        password=123qqq...A

        [server1]
        hostname=192.168.4.51
        candidate_master=1

        [server2]
        hostname=192.168.4.52
        candidate_master=1

        [server3]
        hostname=192.168.4.53
        candidate_master=1

        [server4]
        hostname=192.168.4.54
        no_master=1

        [server5]
        hostname=192.168.4.55
        no_master=1        
        ```
        - 创建故障切换切换脚本
        vim +35 master_ip_failover #修改35行的ip地址即可
        ```  
        my $vip = '192.168.4.100/24';  # Virtual IP
        ```
        - 把vip地址部署在当前的主库上
          51 ----->  ifconfig eth0:1 192.168.4.100/24 #临时有效，重启清空,不能永久修改!!!

        - 用户授权(由配置文件)
          #同步数据,授权用户
          repl_user=plj
          repl_password=123qqq...A
          #监控数据库状态的用户
          user=root
          password=123qqq...A
        - 给从服务器同步数据的连接用户(51 52 53)
        >>> 51 && 52 && 53 ---> grant replication slave on *.* to plj@"%" identified by "123qqq...A";

        - 管理主机56监视数据服务器状态的连接用户(51 52 53 54 55)
        >>> grant all on *.* to root@"%" identified by "123qqq...A";
        只需要在51上做，因为52-55都是51的从服务器，会同步51上的操作。


      3.测试配置
        - ssh无密码的登陆
        masterha_check_ssh --conf=/etc/mha_manager/app1.cnf
        >>>  All SSH connection tests passed successfully.

        - mysql主从同步
        1.masterha_check_repl --conf=/etc/mha_manager/app1.cnf

        2. MySQL Replication Health is NOT OK!
            - 可能出现的问题： 用户授权、配置文件、主从同步方式、vip、
        - 启动管理服务
        1. masterha_check_repl --conf=/etc/mha_manager/app1.cnf\(选项)
        --remove_dead_master_conf : 会自动删除(宕机)主库的信息
        --ignore_last_failover  ： 会忽略
        >>> masterha_manager  --conf=/etc/mha_manager/app1.cnf --remove_dead_master_conf --ignore_last_failover   #需要在另一个终端启动
        >>> masterha_check_status --conf=/etc/mha_manager/app1.cnf
          app1 (pid:3648) is running(0:PING_OK), master:192.168.4.51  #查看状态

        - mysql服务高可用
        1.在主数据库上添加访问数据的连接用户
              grant select ,insert on db9.* to yaya99@"%" identified by "123qqq...A";
        2.在客户端50连接vip地址访问数据路服务
              50 ： mysql -h 192.168.4.100 -uyaya99 -p123qqq.A
              msyql > insert into db9.t1 values(100),(200),(300);
              msyql > select * from db9.t1;
              在51所有从服务器上都可以看到同样的数据
        3.停止主数据库51数据库服务，50主机依然可以访问到数据
              - 将51的数据库停掉，查看56的一个终端信息，
              - 查看51~53的ip ，谁拥有eth0：1 的VIP;

        4.如果52也坏掉了，53会不会成为主库
            这个会成为最后的一个主库
            ```
            [server default]
            manager_log=/etc/mha_manager/manager.log
            manager_workdir=/etc/mha_manager
            master_ip_failover_script=/etc/mha_manager/master_ip_failover
            password=123qqq...A
            repl_password=123qqq...A
            repl_user=plj
            ssh_port=22
            ssh_user=root
            user=root

            [server3]
            candidate_master=1
            hostname=192.168.4.53

            [server4]
            hostname=192.168.4.54
            no_master=1

            [server5]
            hostname=192.168.4.55
            no_master=1
            ```
              注意： 在主库宕掉了，需要我们手动启动。
        5.如把宕掉的51服务器，再次添加到集群当中。
          需要把宕数据库服务器重新启动。
          把宕掉51，52配置为当前得 主服务器的从服务器
          把主机51和52添加app1.cnf文件里
            [server1]
            candidate_master=1
            hostname=192.168.4.51
            [server2]
            candidate_master=1
            hostname=192.168.4.51
          把主机56上运行管理服务，并查看服务状态
          masterha_check_repl --conf=/etc/mha_manager/app1.cnf
          masterha_manager --conf=/etc/mha_manager/app1.cnf 
