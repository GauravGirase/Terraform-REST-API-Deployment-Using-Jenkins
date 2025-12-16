#! /bin/bash
cd /home/ubuntu
yes | sudo apt update
yes | sudo apt install python3 python3-pip awscli 
# Fetch from SSM
DB_ENDPOINT=$(aws ssm get-parameter \
  --name "/prod/db/endpoint" \
  --query "Parameter.Value" \
  --output text \
  --region ap-south-1)

DB_NAME=$(aws ssm get-parameter \
  --name "/prod/db/name" \
  --query "Parameter.Value" \
  --output text \
  --region eu-south-1)

# Fetch from Secrets Manager
SECRET=$(aws secretsmanager get-secret-value \
  --secret-id "prod/db/credentials" \
  --query "SecretString" \
  --output text \
  --region eu-central-1)

DB_USER=$(echo $SECRET | jq -r '.username')
DB_PASSWORD=$(echo $SECRET | jq -r '.password')

# Export env vars
cat <<EOF >> /etc/environment
DB_ENDPOINT=$DB_ENDPOINT
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD
EOF

git clone -b flask-api https://github.com/GauravGirase/Terraform-REST-API-Deployment-Using-Jenkins.git
sleep 20
cd Terraform-REST-API-Deployment-Using-Jenkins
pip3 install -r requirements.txt
echo 'Waiting for 30 seconds before running the app.py'
setsid python3 -u app.py &
sleep 30
