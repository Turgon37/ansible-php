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

## OS Family

This role is available for Debian

## Features

At this day the role can be used to :

  * install php
  * [local facts](#facts)

## Configuration

### Role

All variables which can be overridden are stored in [defaults/main.yml](defaults/main.yml) file as well as in table below. To see default values please refer to this file.

| Name | Description  |
| ---- | ------------ |
| ``   |              |

## Facts

By default the local fact are installed and expose the following variables :

* ```ansible_local.```


## Example

### Playbook

Use it in a playbook as follows:

```yaml
- hosts: all
  roles:
    - turgon37.php
```

### Inventory