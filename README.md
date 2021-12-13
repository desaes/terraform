# Description

This is my terraform lab while studying for Terraform certification

## License

GPL

## Tips

- SSH

  - **SSH key generation:**

  ```
  ssh-keygen -t rsa -f ssh-key -m pem
  ```

  - **SSH with Windows**

  ```
  icacls .\private.key /inheritance:r
  icacls .\private.key /grant:r "%username%":"(R)"
  ```

- EC2
  - **List EC2 instances:**
  ```
  aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,InstanceId:InstanceId}" --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values='*'"
  ```
  - **Retrieve EC2 instance password:**
  ```
  aws ec2 get-password-data --instance-id <instance_id> --priv-launch-key <priv_key>
  ```

## Demos

| Directory        | Content                                                                                                                              |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| demos/aws/skel   | skeleton to start a new demo                                                                                                         |
| demos/aws/d00    | AWS - instance provisioning (linux)                                                                                                  |
| demos/aws/d01    | AWS - instance provisioning (linux), file upload, security group, remote-exec                                                        |
| demos/aws/d02    | AWS - instance provisioning (windows), user data, file upload, security group, local-exec, and output                                |
| demos/aws/d03    | AWS - instance provisioning (windows), user data, file upload, security group, local-exec, output, and terraform backend for tfstate |
| demos/aws/d04    | AWS - datasource, for-each loop                                                                                                      |
| demos/aws/d05    | AWS - module **(external module not working)**                                                                                       |
| demos/aws/d06    | AWS - vpc, internet gateway, subnets, nat gateway, routes                                                                            |
| demos/aws/d07    | AWS - vpc, internet gateway, subnets, nat gateway, routes, ec2 instance, security group                                              |
| demos/aws/d08    | AWS - instance, root volume, ebs volume                                                                                              |
| demos/aws/d09    | AWS - instance, ebs volume, user data, cloud init, automatic ebs mount                                                               |
| demos/aws/d10    | AWS - route53, eip                                                                                                                   |
| demos/aws/d11    | AWS - rds                                                                                                                            |
| demos/aws/d12    | AWS - iam                                                                                                                            |
| demos/aws/d13    | AWS - (s3, dynamodb_table for backend locking), iam role and policies                                                                |
| demos/aws/d14    | AWS - autoscaling group                                                                                                              |
| demos/aws/d15    | AWS - elb and autoscaling group                                                                                                      |
| demos/aws/d16    | AWS - alb **(under construction)**                                                                                                   |
| demos/aws/d17    | AWS - elastic beanstalk                                                                                                              |
| demos/aws/d18    | AWS - conditionals                                                                                                                   |
| demos/aws/d19    | AWS - development, production **project directory**                                                                                  |
| demos/aws/d20    | AWS - ecr, run it before d21, push the docker app image and import this repo in d21                                                  |
| demos/aws/d21    | AWS - ecs (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html), must have an app in ecr repo         |
| demos/aws/d22    | AWS - modules                                                                                                                        |
| demos/aws/d23    | AWS - another alb                                                                                                                    |
| demos/aws/d24    | AWS - directory isolation, remote_state_file                                                                                         |
| demos/aws/d25    | AWS - d24 + local modules for web services                                                                                           |
| demos/aws/d26    | AWS - d26 + remote modules (git) for web services + module versioning                                                                |
| demos/aws/d27    | AWS - count, for_each, for (modules/prod/webservices), conditionals                                                                  |
| demos/aws/d28    | AWS - zero downtime ASG (explicit dependency among aws_autoscaling_group and aws_launch_configuration)                                                                                                              |
| demos/aws/d29    | AWS - modules for RDS, ASG, ALB, Instance, examples, explicit dependency among aws_autoscaling_group and aws_launch_configuration                                                                                  |
| demos/kplabs/d00 | provider definition and strict version requirement for the provider                                                                  |
