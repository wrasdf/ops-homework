## What's this repo.

- CloudFormation for EC2 Deployment
- CloudFormation for ECS Deployment

### Deploy to EC2 instance

- [Change Logs](https://github.com/wrasdf/ops-homework/blob/master/EC2/changelog.md)

- build the demo app & push to docker hub

```
docker login
make push-v0.1.0
```

- Create the EC2 VPC stack
```
make deploy-ec2-vpc
```

- Deploy your app into EC2
```
make deploy-ec2-app
```

- Create the bashion EC2 for debug
```
make deploy-ec2-bastion
```

### Deploy to ECS

- [Change Logs](https://github.com/wrasdf/ops-homework/blob/master/ECS/changelog.md)


- build the demo app & push to docker hub

```
docker login
make push-v0.1.0
```

- Create the ECS VPC stack
```
make deploy-ecs-vpc
```

- Build your cluster environment
```
make deploy-ecs-cluster
```

- Deploy your service into ECS
```
make deploy-ecs-service
```
