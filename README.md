Role Name
=========

Upload backups to s3 compatible object storages

Requirements
------------

- debian based linux distribution
- pip3 (able to install)
- s3cmd (able to install)

Role Variables
--------------

A description of the settable variables for this role are available in defaults/vars.yml


Example Playbook
----------------

```yaml
- hosts: cluster
  roles:
  - role: ans-backuper
    tags:
    - backup
    vars:
      S3_ENDPOINT:
      S3_ACCESS_KEY:
      S3_SECRET_KEY:


License
-------

BSD

Author Information
------------------
msirovy@gmail.com
