andrewrothstein.yq
=========
![Build Status](https://github.com/andrewrothstein/ansible-yq/actions/workflows/build.yml/badge.svg)

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
