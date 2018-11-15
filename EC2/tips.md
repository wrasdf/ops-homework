### Errors

Cloud-init v. 18.2-72.amzn2.0.6 running 'modules:final' at Mon, 12 Nov 2018 05:50:04 +0000. Up 13.76 seconds.
[   14.244727] cloud-init[4138]: + yum update -y aws-cfn-bootstrap awscli
[   14.280488] cloud-init[4138]: Loaded plugins: priorities, update-motd, upgrade-helper
[   14.590251] cloud-init[4138]: Package(s) aws-cfn-bootstrap available, but not installed.
[   14.612436] cloud-init[4138]: Package(s) awscli available, but not installed.
[   14.626661] cloud-init[4138]: No packages marked for update
[   14.635166] cloud-init[4138]: + /opt/aws/bin/cfn-init -v --region ap-southeast-1 --stack myEC2-Stack-app --resource EC2ServerLaunchConfiguration
[   14.649321] cloud-init[4138]: /var/lib/cloud/instance/scripts/part-001: line 5: /opt/aws/bin/cfn-init: No such file or directory
[   14.664928] cloud-init[4138]: + error_exit 'Failed to run cfn-init'
[   14.673784] cloud-init[4138]: /var/lib/cloud/instance/scripts/part-001: line 5: error_exit: command not found
[   14.681825] cloud-init[4138]: Nov 12 05:50:04 cloud-init[4138]: util.py[WARNING]: Failed running /var/lib/cloud/instance/scripts/part-001 [127]
ci-info: +++Authorized keys from /home/ec2-user/.ssh/authorized_keys for user ec2-user++++
