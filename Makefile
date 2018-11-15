.PHONY: run

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
verify-ec2-%:
	$(DCR) aws cloudformation validate-template --template-body file:///app/EC2/cfn/$(*).yaml

deploy-ec2-%:
	make verify-ec2-$(*)
	$(DCR) stackup ec2-stack-$(*) up -t ./EC2/cfn/$(*).yaml -p ./EC2/params/dev/$(*).yaml


#for ECS
verify-ecs-%:
	$(DCR) aws cloudformation validate-template --template-body file:///app/ECS/cfn/$(*).yaml

verify-service-%:
	$(DCR) aws cloudformation validate-template --template-body file:///app/ECS/cfn/services/$(*).yaml


deploy-ecs-%:
	make verify-ecs-$(*)
	$(DCR) stackup ecs-stack-$(*) up -t ./ECS/cfn/vpc.yaml -p ./ECS/params/dev/$(*).yaml

deploy-service-%:
	make verify-ecs-service-$(*)
	$(DCR) stackup ecs-stack-service-$(*) up -t ./ECS/cfn/services/$(*).yaml -p ./ECS/params/dev/services/$(*).yaml
