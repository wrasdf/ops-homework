### How to get region ami
- `aws region` -> update default region
- `aws ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux/recommended --query "Parameters[].Value" --output text | jq .`
