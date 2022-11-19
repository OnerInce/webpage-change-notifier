<h3 align="center">Serverless Web Page Change Notifier</h3>

This simple serverless Lambda application, written in Python and Terraform, regularly checks for the changes on a webpage and notifies the user using AWS SNS


## 📝 Table of Contents
+ [How it works](#working)
+ [How to Deploy](#deploy)


## 💭 How it works <a name = "working"></a>
- Lambda scraper function runs on a schedule (every 1 hour) and saves page source HTML to DynamoDB
- Using [DynamoDB Streams](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Streams.html), any changes on the page HTML gets detected. Second (notifier) Lambda function gets triggered
- Notifier Lambda function sends a message to SNS topic
- Notification gets delivered to topic subscribers

## 🎈 How to Deploy <a name = "deploy"></a>

First, customize the paramaters defined in [template.yaml](/sam/app/template.yaml)

There are 2 parts to deploy:

- Lambda functions with SAM

    ```
    cd sam/app
    ```
    
    Build:

    ```
    sam build --use-container
    ```

    Deploy to AWS:

    ```
    sam deploy --guided
    ```

    To configure and customize SAM template, see the [documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)

- Other AWS Resources with Terraform

    Terraform is the Infrastructure as code (IaC) tool that I used in this proejct to manage other AWS resources. 

    After configuring required backend ([see here](https://developer.hashicorp.com/terraform/language/settings/backends/configuration)), customize the [prod.tfvars](/terraform/prod.tfvars) file. 

    ```
    cd terraform
    ```

    Plan to see which resources will be created:

    ```
    terraform plan --var-file=prod.tfvars
    ```

    Create all resources on your account:

    ```
    terraform apply --var-file=prod.tfvars
    ```

