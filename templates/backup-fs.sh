#!/bin/bash -l

# Example
# backup_fs_config:
# - name: Backup data
#   cron: 
#   src: /data/
#   dest: "s3://backup-bucket/node_name/data/data"
#   options:
#   - '--exclude="*.iso"' 
