## Change list:

### version 0.0.3
- Add vpv-flow-logs
- ADD DB subnet

### version 0.0.2
- Add ENV support
- Make sure ELB in the public subnet
- update ELB SG Port 3000 -> 80
- new AMI Id -> ami-7e957e1c
- update new AMI include cfn-signal commands
- update new AMI include awscli(docker & awscli & ubuntu 16.04)
- ADD cfn-signal
- commfirmed -> the healthy check on ASG is "ELB"
  - avoid instance is running, but application dead.

### Version 0.0.1
- Remove AssociatePublicIpAddress from launchConfig
- Add DHCP
- Use Export & ImportValue in cfn

### Nodes:
- Docker will automatically have the permission which in EC2 instance
- Docker need to do something when on ECS
- ELB security group with EC2 security group  

### TODOS:
- Use packer build a AMI ok  
- Docker image for node server (local & docker hub)  ok
- Run first nodejs server on EC2
 - create a VPC use cfn
   - VPC  ok
   - DHCP ok
   - AvailabilityZone  ok
   - Public Subnet ok
   - Private Subnet ok
   - Internet Gateway ok
   - NAT Gateway ok
   - RouteTable with Route ok
 - create a application in EC2 in vpc use cfn
   - ELB ok
   - ELB SecurityGroup ok
   - EC2 ASG ok
   - EC2 SecurityGroup  ok
   - EC2 LaunchConfiguration  ok
   - Instance Role  ok
   - logs -- ?
 - Add Alarms & monitoring ?
   - HealthyHostAlarm
   - HttpErrorAlarm
   - HealthyHostAlarm     

### Need to improve:
- add more availablity zoon ok
- blue and green deploy
  - updatepolicy 50%
  - createpolicy 50%
- env support ok  
