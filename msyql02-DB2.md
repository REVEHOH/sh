回顾知识点：
  异步复制
  全同步复制
  半同步复制



  SQL 查询优化
    数据库
    查看与查询缓存的相关比变量 : show variables like "query_cache%";
      - query_cache_size ： 缓存的大小
      - query_cache_type ： 是否开启缓存服务
    View the current query cache statistics ：  show global status like "qcache%";
      - Qcache_hits : 50
      - Qcache_inserts ：100

      优化程序员优优化访问数据的sql命令
        查询日志 ： 记录在服务器上执行的所有命令
        [mysqld]
        general-log
        保存重启
        存储的位置&文件名 ：  /var/lib/mysql/host(主机名).log

        慢查询日志： 记录在服务器上执行的记录执行时间比较长的查询语句或者不使用索引select命令
        [mysqld]
        slow-query-log
        long-query-time=5 --->可以值指定查询的超时间，默认10s
        long-querire-not-using-indexes
        保存重启
        存储位置&文件名 ： /var/lib/mysql/(主机名)-slow.log;
        测试：
          select sleep(11);
          #在日志文件中，会增加记录
