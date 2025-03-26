# Terraform Practical Lab 8:

## Description
This project demonstrates advanced Terraform features such as loops (`count` and `for_each`), functions, expressions, and modular configurations. The infrastructure includes:
- Multiple EC2 instances
- Security groups with dynamic ingress rules
- VPC setup, internet gateway,subnets, and route tables
- Various Terraform built-in functions to enhance automation and reusability

## Prerequisites
- Terraform CLI installed
- AWS credentials configured
- Basic understanding of Terraform concepts

## Project Structure
```
/Practical-Lab-8/
  ├── main.tf
  ├── variables.tf
  ├── outputs.tf
  ├── modules/
  │   ├── ec2/
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
  │   ├── security-groups/
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
  │   ├── vpc/
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
  ├── README.md
```

## Terraform Command to Execute
1. Initializing Terraform Configs in the Backend:

#   terraform init

2. Plan the infrastructure for your AWS Provider with the configuration scripts:

#   terraform plan
   
3. Applying the configuration:

#   terraform apply 

4. Destroy resources when done (Optional - Incase of any changes or anything goes wrong): 

#   terraform destroy 

## Terraform Loops (`count` and `for_each`)
- `count`  Used to create multiple identical EC2 instances.
- `for_each`  Used to create dynamic security groups based upon a predefined configurations from the modules.

## Functions Used in Terraform Configurations
This project demonstrates:
- String functions: (`upper`, `lower`)
- Numeric functions: (`min`, `max`)
- Collection functions: (`concat`, `length`)
- Networking functions: (`cidrsubnet` for subnet allocations)

## Enhanced Configurations
- Modularization: Code is organized into reusable modules (`ec2`, `security`, `vpc`).
- Dynamic expressions: Used for flexibility of our code (e.g., dynamic blocks for ingress rules).

## Lessons Learned
- `count` is useful for identical resources, while `for_each` provides flexibility for unique configurations.
- Terraform functions improves automated provisioning of our infrastruccture, readability, and reusability.
- Modularization makes Terraform configurations more maintainable and scalable and reusable.

## Repository
[GitHub Repo Link - Replace with actual link]

## Created By
[Group 2]

 ## Members
Prem Chander Jebastian
Rishi Patel
Twinkle Mishra
