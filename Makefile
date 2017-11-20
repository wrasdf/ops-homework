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

cfn-verify-app:
	$(DCR) aws cloudformation validate-template --template-body file:///app/cloudformation/app.yaml

cfn-verify-vpc:
	$(DCR) aws cloudformation validate-template --template-body file:///app/cloudformation/vpc.yaml

cfn-verify-bastion:
	$(DCR) aws cloudformation validate-template --template-body file:///app/cloudformation/bastion.yaml

cfn-vpc: cfn-verify-vpc
	$(DCR) stackup myCFNN-new up -t ./cloudformation/vpc.yaml

cfn-app: cfn-verify-app
	$(DCR) stackup myCFNN-app up -t ./cloudformation/app.yaml

cfn-bastion: cfn-verify-bastion
	$(DCR) stackup myCFNN-bastion up -t ./cloudformation/bastion.yaml

scp:
	scp -i $(HOME)/.ssh/kerry_aws_key.pem $(HOME)/.ssh/kerry_aws_key.pem ubuntu@$(IP):/tmp/