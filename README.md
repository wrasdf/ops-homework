## What's this repo.

- CloudFormation for EC2 Deployment
- CloudFormation for ECS Deployment

### Deploy to EC2 instance

- build ami by packer
```
make build-ami
```

- build the demo app & push to docker hub

```
docker login
make push-v0.1.0
```

- Create the EC2 VPC stack
```
make cfn-ec2-vpc
```

- Deploy your app into EC2
```
make cfn-ec2-app
```

- Create the bashion EC2 for debug
```
make cfn-ec2-bastion
```


### Deploy to ECS

- build the demo app & push to docker hub

```
docker login
make push-v0.1.0
```

- Create the ECS VPC stack
```
make cfn-ecs-vpc
```

- Build your cluster environment
```
make cfn-ecs-cluster
```

- Deploy your service into ECS
```
make cfn-ecs-service
```
