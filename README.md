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

- Create the bashion EC2 for debug
```
make deploy-ec2-bastion
```

- Deploy your app into EC2
```
make deploy-ec2-app
```


### Deploy to ECS

- [Change Logs](https://github.com/wrasdf/ops-homework/blob/master/ECS/changelog.md)


- build the demo app & push to docker hub

```
docker login
make push-node-0.1.1
make push-py-0.1.1
```

- Create the ECS VPC stack
```
make deploy-ecs-vpc

```

- Create the bashion EC2 for debug
```
make deploy-ecs-bastion
```

- Build your cluster environment
```
make deploy-ecs-cluster
```

- Deploy your services into ECS
```
make deploy-service-todo
make deploy-service-py
```

#### References:
- ECS:
  - https://github.com/aws-samples/ecs-refarch-cloudformation
  - https://github.com/aws-samples/ecs-refarch-cloudformation/issues/13
