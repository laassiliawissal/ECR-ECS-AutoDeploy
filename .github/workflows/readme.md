#

<h1> </h1>
<h3>1. Log in to aws</h3>

**create an admin user**  
  
as good practice login as user with admin persmissions rather than Root user. 
log in as user root, go to IAM service -> users -> create a user. 
go to permissions give admin permissions. 


<div center>
  <img width="961" alt="adminpolicytouser" src="https://github.com/laassiliawissal/ECR-ECS-AutoDeploy/assets/42965555/634cdc11-fa4e-4ba1-a45f-d2f294a37121">
</div>

<h4> Define a password to the user </h4>

Make sure to define a password for this specific user. download credentials as CSV and keep it in a safe place.
<h4> get security credentials</h4>
head to aws IAM service, choose Users, select from the list the User you just created as an ADMIN. 


**Login in from console**
 Logout from root, and login as user. Enter the Acount ID or Account Alias _ which you can get it from top right corner on the console / or from the Dashboard of the IAM service _ enter the username and password.

 

**login from CLI**  
How to get ACCESS_KEY_ID AND SECRET_KEY ?  
Go security credentials tab,click create access key, make sure to save the CSV file on safe place.  
  
Run the following comand to login to aws, provide the ACCESS_KEY_ID AND SECRET_KEY:  
```node.js
# login to aws from CLI using User ACCESS_KEY_ID AND SECRET_KEY
aws configure

```

To check which region you are in, run the following command:

```node.js
# check your current region region
aws configure get region

```

To check which user is logged in, run the following command:

```node.js
# check your IAM user information
aws iam get-user

```

<h3>2. Create aws ECR repository</h3>  
To create repository in aws ECR, run the following command:  


```node.js
# create ECR reppository named my-first-repo
aws ecr create-reppository --repository-name my-first-repo

```
Check your repo is created successfully, run:  
```node.js
# list the repository within your current region
aws ecr describe-repositories

```

<h3>Create an ECS task definition, an ECS cluster, and an ECS service</h3>  
<h4> Create an ECS task definition </h4>

````
#create ECS task definition
(base) laassiliawissal@MBPdeLaassilia ECR-ECS-AutoDeploy % aws ecs register-task-definition --cli-input-json file://task-definition.json 

```

```
#list task definition in ECS
(base) laassiliawissal@MBPdeLaassilia ECR-ECS-AutoDeploy % aws ecs list-task-definitions
{
    "taskDefinitionArns": [
        "arn:aws:ecs:us-east-1:147147982092:task-definition/hello-world-task:1"
    ]
}

```

<h4> Create an ECS cluster </h4>
`````
#create an  ECS Cluster
aws ecs create-cluster --cluster-name hello-world-cluster
#list ECS Clusters
aws ecs list-clusters
``



<h4> Create an ECS service </h4>

1. Naming
Application Name: hello-world-app
Cluster Name: hello-world-cluster
Service Name: hello-world-service
Task Definition Family: hello-world-task
Container Name: hello-world-container

<!--
VPC ID: vpc-003915be8c017d689
Subnet ID 1: subnet-0e8463235bdd567e1
Subnet ID 2: "subnet-0e8463235bdd567e1
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-003915be8c017d689"
-->


`````
#get your VPC Id
aws ec2 describe-vpcs --query 'Vpcs[0].VpcId' --output text

# get you Subnet ID, rplace c
aws ec2 describe-subnets --filters "Name=vpc-id,Values=your-vpc-id"

# get subnet of a specific AZ
aws ec2 describe-subnets --filters "Name=availability-zone,Values=us-east-1a,us-east-1b"

``

2. Create a Security Group:

``````
# Create a Securiry Group
aws ec2 create-security-group --group-name hello-world-sg --description "Security group for Hello World app" --vpc-id your-vpc-id

# list security Groups
aws ec2 describe-security-groups
aws ec2 describe-security-groups --filters "Name=group-name,Values=hello-world-sg"

``

cluster hello-world-cluster
service-name hello-world-service
task-definition hello-world-task 
task-definition file named task-definition
repository-name my-first-repo
containe name: "hello-world-container",
            and "image": "nginx:latest",



``````
# Create ECS Service

aws ecs create-service --cluster hello-world-cluster \
  --service-name hello-world-service \
  --task-definition hello-world-task \
  --desired-count 1 \
  --launch-type EC2 \
  --network-configuration "awsvpcConfiguration={subnets=['your-subnet-1','your-subnet-2'],securityGroups=['your-sg-id']}"

# List ECS Service

aws ecs list-services --cluster hello-world-cluster



``````

<!--
aws ecs create-service --cluster hello-world-cluster \
  --service-name hello-world-service \
  --task-definition hello-world-task \
  --desired-count 1 \
  --launch-type EC2 \
  --network-configuration "awsvpcConfiguration={subnets=['subnet-0e8463235bdd567e1','subnet-0e8463235bdd567e1'],securityGroups=['sg-0aa7a3e98a77d1061']}"


<h1> title </h1>
<h2> title </h2>
<h3> title </h3>
<h4> title </h4>
<h5> title </h5>
<h6> title </h6>
--> 



