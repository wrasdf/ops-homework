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
	$(DCR) stackup myEC2Stack up -t ./EC2-cloudformation/vpc.yaml -p ./EC2-cloudformation/dev/parameters-vpc.yaml

cfn-ec2-app: cfn-verify-ec2-app
	$(DCR) stackup myEC2Stack-app up -t ./EC2-cloudformation/app.yaml -p ./EC2-cloudformation/dev/parameters-app.yaml

cfn-ec2-bastion: cfn-verify-ec2-bastion
	$(DCR) stackup myEC2Stack-bastion up -t ./EC2-cloudformation/bastion.yaml

scp:
	scp -i $(HOME)/.ssh/kerry_aws_key.pem $(HOME)/.ssh/kerry_aws_key.pem ubuntu@$(IP):/tmp/