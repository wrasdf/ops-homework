## version 0.0.2
- Add Bastion Stack
- VPC Stack
  - add vpv-flow-logs
  - add DB private subnets
- Cluster Stack
  - Base on Region to decide the AMI
- Services Stack
  - Add two micro services
  - Fix ServiceListenerRule issue

## version 0.0.1

### CloudFormation Details
- vpc.yaml
  - 2 AvailabilityZone
  - 2 public subnets
  - 2 private subnets
  - 2 NatGateway
- cluster.yaml
  - ECS Cluster
  - 1 ALB & ALB SecurityGroup
  - ECS Cluster Host AutoScalingGroup
  - ECS Cluster Host Scaleup
  - ECS Cluster Host ScaleDown
  - ECS Cluster Host SecurityGroup
  - ECS Cluster Host LaunchConfiguration
  - ECS Cluster Host Role
- service.yaml
  - ECS Service
  - TaskDefinition
  - ServiceListener
  - ServiceTargetGroup
  - ServiceRole
  - ServiceScalingTarget
  - ServiceScalingUp
  - ServiceScalingDown
  - ServiceAutoscalingRole
  - CloudWatchLogsGroup
