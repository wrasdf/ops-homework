#!/bin/bash -xe

# install Docker 
sudo -S sh -c "curl -s -L https://raw.githubusercontent.com/docker/docker-install/master/install.sh | bash"

# install awscli pip aws-cfn-bootstrap-latest
sudo -S sh -c "mkdir -p /tmp/aws-cfn-bootstrap-latest"
sudo -S sh -c "curl https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-1.4-8.tar.gz | tar xz -C /tmp/aws-cfn-bootstrap-latest --strip-components 1"
sudo -S sh -c "curl https://s3-ap-southeast-2.amazonaws.com/bucket/cfn-hup.service -o /etc/systemd/system/cfn-hup.service"
sudo -S sh -c "apt-get update && apt-get install -y python-pip libssl-dev libffi-dev"
sudo -S sh -c "pip install --upgrade pip && pip install awscli pyopenssl ndg-httpsclient pyasn1"
sudo -S sh -c "pip install --upgrade /tmp/aws-cfn-bootstrap-latest"
sudo -S sh -c "cp /tmp/aws-cfn-bootstrap-latest/init/ubuntu/cfn-hup /etc/init.d/cfn-hup"
sudo -S sh -c "chmod 755 /etc/init.d/cfn-hup"