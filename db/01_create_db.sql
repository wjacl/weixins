create database weixins DEFAULT charset utf8;

create user 'weixins'@'%' IDENTIFIED by 'weixins';
create user 'weixins'@'localhost' IDENTIFIED by 'weixins';

grant all PRIVILEGES on weixins.* to 'weixins'@'%';
grant all PRIVILEGES on weixins.* to 'weixins'@'localhost';