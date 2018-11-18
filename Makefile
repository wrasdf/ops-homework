.PHONY: run

DCR := docker-compose run --rm

run-node:
	$(DCR) -d -p 3000:3000 node

run-py:
	$(DCR) -d -p 3003:3003 pyapp

push-node-%:
	docker build -t node-app:latest ./apps/node
	docker tag node-app:latest ikerry/node-app:$(*)
	docker tag node-app:latest ikerry/node-app:latest
	docker push ikerry/node-app:$(*)
	docker push ikerry/node-app:latest

push-py-%:
	docker build -t py-app:latest ./apps/py
	docker tag py-app:latest ikerry/py-app:$(*)
	docker tag py-app:latest ikerry/py-app:latest
	docker push ikerry/py-app:$(*)
	docker push ikerry/py-app:latest


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
	$(DCR) stackup ecs-stack-$(*) up -t ./ECS/cfn/$(*).yaml -p ./ECS/params/dev/$(*).yaml

deploy-service-%:
	make verify-service-$(*)
	$(DCR) stackup ecs-stack-service-$(*) up -t ./ECS/cfn/services/$(*).yaml -p ./ECS/params/dev/services/$(*).yaml
