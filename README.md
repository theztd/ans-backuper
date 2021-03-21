Role Name
=========

Upload backups to s3 compatible object storages

Requirements
------------

- debian based linux distribution
- pip3 (able to install)
- s3cmd (able to install)


AWS S3 confiuration
-------------------

 * Bucket configuration example (terraform)
 ```terraform
resource "aws_s3_bucket" "devel_backup_n1" { 
   bucket = "devel-backup-n1"
   acl = "private"
   versioning { 
      enabled = true
   } 
   tags = {
     Name = "DEVEL - backup n1.example.com"
     Environment = "devel"
     Comment = "Bucket for backups"
   }
}
 ```

 * Policy example 
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowsToListBackupBuckets",
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Resource": [
        "arn:aws:s3:::backup*"
      ]
    },
    {
      "Sid": "AllowsToDoS3sync",
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Resource": [
        "arn:aws:s3:::backup-env-mybucketname",
        "arn:aws:s3:::backup-env-mybucketname/*"
      ]
    }
  ]
}

```



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
