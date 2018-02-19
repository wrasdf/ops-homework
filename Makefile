DCR = docker-compose run --rm

AWS_ACCESS_KEY_ID = ""
AWS_SECRET_ACCESS_KEY = ""

build-ami:
	$(DCR) packer build \
		-var aws_access_key=$(AWS_ACCESS_KEY_ID) \
		-var aws_secret_key=$(AWS_SECRET_ACCESS_KEY) \
		./config.json

run:
	$(DCR) node -d -p 3000:3000 node

stop:
	docker stop $$(docker ps -q)

build-image:
	docker build -t ikerry/node-app:latest ./app
	docker push ikerry/node-app:latest


#for EC2
cfn-verify-ec2-app:
	$(DCR) aws cloudformation validate-template --template-body file:///app/EC2-cloudformation/app.yaml

cfn-verify-ec2-vpc:
	$(DCR) aws cloudformation validate-template --template-body file:///app/EC2-cloudformation/vpc.yaml

cfn-verify-ec2-bastion:
	$(DCR) aws cloudformation validate-template --template-body file:///app/EC2-cloudformation/bastion.yaml

cfn-ec2-vpc: cfn-verify-ec2-vpc
	$(DCR) stackup myEC2-Stack up -t ./EC2-cloudformation/vpc.yaml -p ./EC2-cloudformation/dev/parameters-vpc.yaml

cfn-ec2-app: cfn-verify-ec2-app
	$(DCR) stackup myEC2-Stack-app up -t ./EC2-cloudformation/app.yaml -p ./EC2-cloudformation/dev/parameters-app.yaml

cfn-ec2-bastion: cfn-verify-ec2-bastion
	$(DCR) stackup myEC2-Stack-bastion up -t ./EC2-cloudformation/bastion.yaml

scp:
	scp -i $(HOME)/.ssh/kerry_aws_key.pem $(HOME)/.ssh/kerry_aws_key.pem ubuntu@$(IP):/tmp/

#for ECS
cfn-verify-ecs-vpc:
	$(DCR) aws cloudformation validate-template --template-body file:///app/ECS-cloudformation/vpc.yaml

cfn-verify-ecs-cluster:
	$(DCR) aws cloudformation validate-template --template-body file:///app/ECS-cloudformation/cluster.yaml

cfn-verify-ecs-service:
	$(DCR) aws cloudformation validate-template --template-body file:///app/ECS-cloudformation/service.yaml


cfn-ecs-vpc: cfn-verify-ecs-vpc
	$(DCR) stackup myECS-Stack-vpc up -t ./ECS-cloudformation/vpc.yaml -p ./ECS-cloudformation/params/dev/vpc.yaml

cfn-ecs-cluster: cfn-verify-ecs-cluster
	$(DCR) stackup myECS-Stack-cluster up -t ./ECS-cloudformation/cluster.yaml -p ./ECS-cloudformation/params/dev/cluster.yaml

cfn-ecs-service: cfn-verify-ecs-service
	$(DCR) stackup myECS-Stack-service up -t ./ECS-cloudformation/service.yaml -p ./ECS-cloudformation/params/dev/service.yaml
