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
  * monitoring items for
    * Zabbix
  * [local facts](#facts)

## Configuration

### Role

All variables which can be overridden are stored in [defaults/main.yml](defaults/main.yml) file as well as in table below. To see default values please refer to this file.

| Name                                          | Types/Values       | Description                                                                                        |
| --------------------------------------------- | -------------------|--------------------------------------------------------------------------------------------------- |
| `php__version`                                | String             | Choose to PHP version to install (ex 5.6, 7.0) default to latest available in repository           |
| `php__cli`                                    | Boolean            | Install or not php command line SAPI                                                               |
| `php__fpm`                                    | Boolean            | Install or not (and configure) php FPM SAPI                                                        |
| `php__apachemod`                              | Boolean            | Install or not apache mod php SAPI                                                                 |
| `php__apachemod_service_handler`              | String             | The name of ansible handler to notify on apachemod configuration changes                           |
| `php__apachemod_service_name`                 | String             | The name of apache service to restart on apachemod configuration changes                           |
| `php__extensions_global/group/host`           | Dict of extensions | PHP extensions that will be enabled for all SAPI                                                   |
| `php__cli_extensions_global/group/host`       | Dict of extensions | PHP extensions that will be enabled only for cli SAPI (in addition to dict above)                  |
| `php__fpm_extensions_global/group/host`       | Dict of extensions | PHP extensions that will be enabled only for fpm SAPI (in addition to dict two lines above)        |
| `php__apachemod_extensions_global/group/host` | Dict of extensions | PHP extensions that will be enabled only for apachemod SAPI (in addition to dict three lines above)|

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