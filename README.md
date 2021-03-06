Ansible Role PHP
========

[![Build Status](https://travis-ci.org/Turgon37/ansible-php.svg?branch=master)](https://travis-ci.org/Turgon37/ansible-php)
[![License](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)
[![Ansible Role](https://img.shields.io/badge/ansible%20role-Turgon37.php-blue.svg)](https://galaxy.ansible.com/Turgon37/php/)

## Description

:grey_exclamation: Before using this role, please know that all my Ansible roles are fully written and accustomed to my IT infrastructure. So, even if they are as generic as possible they will not necessarily fill your needs, I advice you to carrefully analyse what they do and evaluate their capability to be installed securely on your servers.

This roles install and configures PHP in multiple forms (command line, FPM, apache mod).

## Requirements

Require Ansible >= 2.4

### Dependencies

If you use the zabbix monitoring profile you will need the role [ansible-zabbix-agent](https://github.com/Turgon37/ansible-zabbix-agent)

## OS Family

This role is available for Debian

## Features

At this day the role can be used to :

  * install php
  * SAPIs configuration (cli, apache mod, FPM)
  * FPM pool configuration
  * monitoring items for
    * Zabbix
  * [local facts](#facts)

## Configuration

### Role

All variables which can be overridden are stored in [defaults/main.yml](defaults/main.yml) file as well as in table below. To see default values please refer to this file.

| Name                                          | Types/Values                     | Description                                                                                        |
| --------------------------------------------- | ---------------------------------|--------------------------------------------------------------------------------------------------- |
| `php__version`                                | String                           | Choose to PHP version to install (ex 5.6, 7.0) default to latest available in repository           |
| `php__cli`                                    | Boolean                          | Install or not php command line SAPI                                                               |
| `php__fpm`                                    | Boolean                          | Install or not (and configure) php FPM SAPI                                                        |
| `php__apachemod`                              | Boolean                          | Install or not apache mod php SAPI                                                                 |
| `php__apachemod_service_restart_handler`      | String                           | The name of ansible handler to notify on apachemod configuration changes that require restart      |
| `php__apachemod_service_reload_handler`       | String                           | The name of ansible handler to notify on apachemod configuration changes that require reload       |
| `php__apachemod_service_name`                 | String                           | The name of apache service to restart on apachemod configuration changes                           |
| `php__extensions_global/group/host`           | Dict of extensions (see below)   | PHP extensions that will be enabled for all SAPI                                                   |
| `php__cli_extensions_global/group/host`       | Dict of extensions (see below)   | PHP extensions that will be enabled only for cli SAPI (in addition to dict above)                  |
| `php__fpm_extensions_global/group/host`       | Dict of extensions (see below)   | PHP extensions that will be enabled only for fpm SAPI (in addition to dict two lines above)        |
| `php__apachemod_extensions_global/group/host` | Dict of extensions (see below)   | PHP extensions that will be enabled only for apachemod SAPI (in addition to dict three lines above)|
| `php__settings_global/group/host`             | Dict of PHP settings (see below) | PHP settings that will be applied to all SAPI                                                      |
| `php__cli_settings_global/group/host`         | Dict of PHP settings (see below) | PHP settings that will be applied to cli SAPI                                                      |
| `php__fpm_settings_global/group/host`         | Dict of PHP settings (see below) | PHP settings that will be applied to FPM SAPI                                                      |
| `php__apachemod_settings_global/group/host`   | Dict of PHP settings (see below) | PHP settings that will be applied to apachemod SAPI                                                |

#### Version

By default, this role apply the latest version available in Debian repositories, so if you have any another version available in another third-party repository you can use the php__version but this have not yet tested anyway.

#### Extensions

In Debian distribution, each PHP mod must be enabled using a associated configuration file part in conf.d/.
In order to simplify the PHP module activation, you have just to list each extension name that you want as a key per extension name like the following example.
Ansible will try to install the optional corresponding required package using a map defined in [defaults/main.yml](defaults/main.yml#39).

```
php__fpm_extensions_group:
  bcmath:
  ctype:
  dom:
  gd:
  gettext:
  ldap:
  mbstring:
  mysqlnd:
  mysqli:
  sockets:
  xml:
  xmlreader:
  xmlwriter:
```

#### PHP settings

Each PHP settings consists in one or several key, value in ini file format pair.
Theses values are stored in php.ini files. Some values requires a section.
Each item in php__*settings* dict represent a key, value pair. You can specify the section name as first part of the item key using a slash to separate the two parts. See this example

```
Date/date.timezone: 'Europe/Paris'
```

Will results in

```
[Date]
date.timezone = Europe/Paris.
```

Takes care of yaml interpretations of booleans and use correct quoting:

```
php__settings_global:
  Date/date.timezone: 'Europe/Paris'
  PHP/expose_php: 'Off'
```

## Facts

I deliver the following facts with this role. This is explicitly NOT intended to be used within your ansible run as it will only work on your second run. Its intention is to make querying versions per server.

* ```ansible_local.php.version_full```
* ```ansible_local.php.version_major```


## Example

### Playbook

Use it in a playbook as follows:

```yaml
- hosts: all
  roles:
    - turgon37.php
```

### Inventory

Some examples: 

* Using FPM (for zabbix)

```
php__fpm: true
php__fpm_extensions_group:
  bcmath:
  ctype:
  dom:
  gd:
  gettext:
  ldap:
  mbstring:
  mysqlnd:
  mysqli:
  sockets:
  xml:
  xmlreader:
  xmlwriter:

php__fpm_settings_group:
  PHP/memory_limit: 128M
  PHP/post_max_size: 20M
  PHP/upload_max_filesize: 2M
  PHP/max_execution_time: 300
  PHP/max_input_time: 300
# deprecated since 7.0
#  PHP/always_populate_raw_post_data: -1
  Session/session.auto_start: 0
  mbstring/mbstring.func_overload: 0
```

* Using CLI + Apachemod (for Jeedom)

```
php__cli: true
php__apachemod: true
php__extensions_group:
  calendar:
  ctype:
  curl:
  dom:
  ftp:
  gd:
  gettext:
  iconv:
  imap:
  json:
  ldap:
  mcrypt:
  mysqlnd:
  opcache:
  pdo:
  pdo_mysql:
  posix:
  readline:
  simplexml:
  sockets:
  xml:
  xmlrpc:
  xmlreader:
  xmlwriter:
  zip:
  ssh2:

php__settings_group:
  PHP/max_execution_time: 300
  PHP/upload_max_filesize: 1G
  PHP/post_max_size: 1G
  opcache/opcache.enable: 1

php__cli_settings_group:
  opcache/opcache.enable_cli: 1
```
