andrewrothstein.yq
=========
[![Build Status](https://travis-ci.org/andrewrothstein/ansible-yq.svg?branch=master)](https://travis-ci.org/andrewrothstein/ansible-yq)

Installs [yq](https://mikefarah.gitbook.io/yq/).

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.yq
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
