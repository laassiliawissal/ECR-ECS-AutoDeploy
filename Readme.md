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


