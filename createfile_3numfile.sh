#!/bin/sh
for i in {1..9}
do
  for j in {1..9}
  do
    touch /tmp/$i$j$k.txt
  done
done
