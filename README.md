# smarthosts-update

update windows hosts file with latest [smarthost](https://code.google.com/p/smarthosts/ "smarthosts")

## Introduce:
  
This script will download latest SmartHosts 
and update windows hosts file.

> SmartHosts url: [http://smarthosts.googlecode.com/svn/trunk/hosts](`c:/windows/system32/drivers/etc/hosts`)

> windows hosts file path: c:/windows/system32/drivers/etc/hosts

简单的说，就是自动下载最新的SmartHosts配置，更新系统的Hosts文件。
  
## Usage:

It's better to make a schedule to execute this script weekly.

  node update-smarthosts.js`
  
