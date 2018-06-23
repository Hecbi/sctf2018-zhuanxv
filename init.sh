#!/bin/bash
sleep 5s

echo "start"

service mysql start && mysql -e "create database sctf"
mysql sctf < "/home/sctf.sql"
mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root');"