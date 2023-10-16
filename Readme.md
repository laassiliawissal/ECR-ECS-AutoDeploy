<h1>Setting Up and Running the Amazon ECS Deployment Workflow</h1>

Welcome to AWS ECR CES AUTDEPLOY repository! In this README, we'll walk you through the process of setting up and running a powerful GitHub Actions workflow designed to automate the deployment of your containerized application to Amazon Elastic Container Service (ECS). This workflow streamlines the deployment process, making it more efficient and reliable.
<!--
**ECR**: Stands for Amazon Elastic Container Registry, where container images are stored.  
**ECS**: Stands for Amazon Elastic Container Service, where containerized applications are run.   
**Auto-Deploy**: Indicates that the repository automates the deployment process.   
-->


<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!--Prerequisites-->
## Prerequisites
Before you get started with this workflow, ensure that you have the following prerequisites in place:

1. **Amazon Web Services (AWS) Account**: You need an AWS account to create and configure resources like Amazon Elastic Container Registry (ECR), Elastic Container Service (ECS), and access to AWS IAM (Identity and Access Management) for credentials.  

2. **GitHub Repository**: You should have your application code hosted in a GitHub repository.  

3. **Docker**: Docker should be installed locally to build container images.  

4. **IAM User Access Keys**: Create an IAM user in AWS and store the access key and secret access key as GitHub Secrets. These credentials are used for authenticating and interacting with AWS services.  

5.  **Amazon ECS Resources**: You should have an ECS cluster, an ECS service, and an ECS task definition ready. If not, follow AWS documentation or guides to create these resources.  

<!-- ABOUT THE GitHub Actions Workflow Overview -->

## GitHub Actions Workflow Overview

This GitHub Actions workflow streamlines the deployment of containerized applications to Amazon Elastic Container Service (ECS) when changes are pushed to the "main" branch of a GitHub repository. Below is a breakdown of the workflow's components:

### Workflow Setup and Configuration

- **Workflow Name**: The workflow is named "Deploy to Amazon ECS."
- **Trigger**: It is configured to execute when changes are pushed to the "main" branch.
- **Environment Variables**: The workflow defines several environment variables for AWS region, ECR repository, ECS service, ECS cluster, task definition path, and container name.

### Permissions

The workflow is granted read access to the contents of the repository.

### Jobs

The workflow comprises a single job named "Deploy" that runs on an `ubuntu-latest` virtual machine environment.

### Job Steps

1. **Checkout**: 
   - This step checks out the code from the GitHub repository using the `actions/checkout@v3` action.

2. **Configure AWS Credentials**: 
   - This step configures AWS credentials using the `aws-actions/configure-aws-credentials` action. It reads the AWS access key and secret access key from GitHub Actions secrets and sets the AWS region.

3. **Login to Amazon ECR**: 
   - This step logs in to the Amazon Elastic Container Registry (ECR) using the `aws-actions/amazon-ecr-login` action. This is necessary to push Docker images to the ECR repository.

4. **Build, Tag, and Push Image to Amazon ECR**: 
   - This step builds a Docker image using the code in the repository and pushes it to the specified ECR repository. The image is tagged with the GitHub SHA, which is crucial for deploying the application on ECS.

5. **Fill in the New Image ID in the Amazon ECS Task Definition**: 
   - This step updates the ECS task definition with the new Docker image ID. It uses the `aws-actions/amazon-ecs-render-task-definition` action to achieve this.

6. **Deploy Amazon ECS Task Definition**: 
   - Finally, this step deploys the updated ECS task definition to Amazon ECS using the `aws-actions/amazon-ecs-deploy-task-definition` action. It specifies the ECS service, cluster, and waits for the service to reach a stable state.

In summary, this workflow automates the process of building, pushing, and deploying a Docker container image to Amazon ECS when changes are pushed to the "main" branch of the repository. It serves as a typical CI/CD pipeline for containerized applications running on AWS infrastructure.


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!--***************************************************-->

## Preparing Your Environment for Workflow Execution

In this section, I will guide you through the essential steps to set up your environment, ensuring that you are ready to successfully run this GitHub workflow. Proper environment preparation is crucial for the seamless execution of the automation. Follow the steps below to ensure that everything is in place and ready for action.


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

```sh
#create ECS task definition
(base) laassiliawissal@MBPdeLaassilia ECR-ECS-AutoDeploy % aws ecs register-task-definition --cli-input-json file://task-definition.json 

```


```js
#list task definition in ECS
(base) laassiliawissal@MBPdeLaassilia ECR-ECS-AutoDeploy % aws ecs list-task-definitions
{
    "taskDefinitionArns": [
        "arn:aws:ecs:us-east-1:147147982092:task-definition/hello-world-task:1"
    ]
}

```

<h4> Create an ECS cluster </h4>


```sh

#create an  ECS Cluster
aws ecs create-cluster --cluster-name hello-world-cluster
#list ECS Clusters
aws ecs list-clusters

```

<h4> Create an ECS service </h4>

1. Namings
- Application Name: hello-world-app  
- Cluster Name: hello-world-cluster  
- Service Name: hello-world-service  
- Task Definition Family: hello-world-task  
- Container Name: hello-world-container  

<!--
VPC ID: vpc-003915be8c017d689
Subnet ID 1: subnet-0e8463235bdd567e1
Subnet ID 2: "subnet-0e8463235bdd567e1
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-003915be8c017d689"
-->


```sh
#get your VPC Id
aws ec2 describe-vpcs --query 'Vpcs[0].VpcId' --output text

# get you Subnet ID, rplace c
aws ec2 describe-subnets --filters "Name=vpc-id,Values=your-vpc-id"

# get subnet of a specific AZ
aws ec2 describe-subnets --filters "Name=availability-zone,Values=us-east-1a,us-east-1b"

```

2. Create a Security Group:

```sh
# Create a Securiry Group
aws ec2 create-security-group --group-name hello-world-sg --description "Security group for Hello World app" --vpc-id your-vpc-id

# list security Groups
aws ec2 describe-security-groups
aws ec2 describe-security-groups --filters "Name=group-name,Values=hello-world-sg"

```

<!--
cluster hello-world-cluster
service-name hello-world-service
task-definition hello-world-task 
task-definition file named task-definition
repository-name my-first-repo
containe name: "hello-world-container",
            and "image": "nginx:latest",
-->


```sh
# Create ECS Service

aws ecs create-service --cluster hello-world-cluster \
  --service-name hello-world-service \
  --task-definition hello-world-task \
  --desired-count 1 \
  --launch-type EC2 \
  --network-configuration "awsvpcConfiguration={subnets=['your-subnet-1','your-subnet-2'],securityGroups=['your-sg-id']}"

# List ECS Service

aws ecs list-services --cluster hello-world-cluster

```


<!--
aws ecs create-service --cluster hello-world-cluster \
  --service-name hello-world-service \
  --task-definition hello-world-task \
  --desired-count 1 \
  --launch-type EC2 \
  --network-configuration "awsvpcConfiguration={subnets=['subnet-0e8463235bdd567e1','subnet-0e8463235bdd567e1'],securityGroups=['sg-0aa7a3e98a77d1061']}"


--> 



# TroubleShooting:


### Update the task def, and register  it:

```sh

aws ecs register-task-definition --cli-input-json file://task-definition.json
```



### Update the service with the new task
aws ecs update-service --cluster hello-world-cluster --service hello-world-service --task-definition nginx  


To see the Docker images that have been pushed to an Amazon Elastic Container Registry (ECR), you can use the AWS CLI or the AWS Management Console. Here are the steps for using the AWS CLI:   

```sh
#list the images in your ECR repository
aws ecr list-images --repository-name your-repository-name

```
  
The command will return a list of image IDs. To get more details about a specific image, use the describe-images command:  

```sh

aws ecr describe-images --repository-name your-repository-name --image-ids imageTag=your-image-tag
Replace your-image-tag with the image tag of the specific image you want to inspect.

```


