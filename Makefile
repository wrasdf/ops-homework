.PHONY: run verify-ec2-app verify-ec2-vpc verify-ec2-bastion deploy-ec2-vpc deploy-ec2-app deploy-ec2-bastion

DCR := docker-compose run --rm

run:
	$(DCR) node -d -p 3000:3000 node

push-%:
	docker build -t node-app:latest ./app
	docker tag node-app:latest ikerry/node-app:$(*)
	docker tag node-app:latest ikerry/node-app:latest
	docker push ikerry/node-app:$(*)
	docker push ikerry/node-app:latest

#for EC2
verify-ec2-app:
	$(DCR) aws cloudformation validate-template --template-body file:///app/EC2-cloudformation/app.yaml

verify-ec2-vpc:
	$(DCR) aws cloudformation validate-template --template-body file:///app/EC2-cloudformation/vpc.yaml

verify-ec2-bastion:
	$(DCR) aws cloudformation validate-template --template-body file:///app/EC2-cloudformation/bastion.yaml

deploy-ec2-vpc: verify-ec2-vpc
	$(DCR) stackup myEC2-Stack up -t ./EC2-cloudformation/vpc.yaml -p ./EC2-cloudformation/params/dev/vpc.yaml

deploy-ec2-app: verify-ec2-app
	$(DCR) stackup myEC2-Stack-app up -t ./EC2-cloudformation/app.yaml -p ./EC2-cloudformation/params/dev/app.yaml

deploy-ec2-bastion: verify-ec2-bastion
	$(DCR) stackup myEC2-Stack-bastion up -t ./EC2-cloudformation/bastion.yaml -p ./EC2-cloudformation/params/dev/bastion.yaml

scp:
	scp -i $(HOME)/.ssh/kerry_aws_key.pem $(HOME)/.ssh/kerry_aws_key.pem ubuntu@$(IP):/tmp/


#for ECS
verify-ecs-vpc:
	$(DCR) aws cloudformation validate-template --template-body file:///app/ECS-cloudformation/vpc.yaml

verify-ecs-cluster:
	$(DCR) aws cloudformation validate-template --template-body file:///app/ECS-cloudformation/cluster.yaml

verify-ecs-service:
	$(DCR) aws cloudformation validate-template --template-body file:///app/ECS-cloudformation/service.yaml


deploy-ecs-vpc: verify-ecs-vpc
	$(DCR) stackup myECS-Stack-vpc up -t ./ECS-cloudformation/vpc.yaml -p ./ECS-cloudformation/params/dev/vpc.yaml

deploy-ecs-cluster: verify-ecs-cluster
	$(DCR) stackup myECS-Stack-cluster up -t ./ECS-cloudformation/cluster.yaml -p ./ECS-cloudformation/params/dev/cluster.yaml

deploy-ecs-service: verify-ecs-service
	$(DCR) stackup myECS-Stack-service up -t ./ECS-cloudformation/service.yaml -p ./ECS-cloudformation/params/dev/service.yaml
