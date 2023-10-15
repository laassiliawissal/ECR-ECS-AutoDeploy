## Welcome to AWS ECR CES AUTDEPLOY

## In this Repository you will build and push a container Image to aws ECR, and  then Deploy a new Task Definition to aws ECS

**ECR**: Stands for Amazon Elastic Container Registry, where container images are stored.  
**ECS**: Stands for Amazon Elastic Container Service, where containerized applications are run.   
**Auto-Deploy**: Indicates that the repository automates the deployment process.   



# Create an ECS service
aws ecs create-service --cluster hello-world-cluster \
  --service-name hello-world-service \
  --task-definition hello-world-task \
  --desired-count 1 \
  --launch-type EC2 \
  --network-configuration "awsvpcConfiguration={subnets=[your-subnet-1,your-subnet-2],securityGroups=[your-security-group]}"
