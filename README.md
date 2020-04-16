# infra-as-code

This Project contains the AWS CloudFormation scripts to spin up network and server resources for a High Availability S3 hosted web app. 

# Infrastructure Diagram

![Infrastructure Diagram](https://github.com/VeronicaM/infra-as-code/blob/master/architecture-diagram.png)

# Spin up Network Resources

To create the network resources clone this repo and run the following command in the root folder of this repo:

```bash
  ./create-stack.sh your-network-stack-name network.yml network-params.json
```

The following network resources will be created: 

- 2 public networks
- 2 private networks,
- 2 Elastic IPs each associated with 1 NAT that provides Internet access to the private networks
- 1 Internet Gateway,
- 1 Public RouteTable
- 1 Private Route Table
- 1 Public Routes and RouteTableAssociation for the public subnet
- 1 Public Routes and RouteTableAssociation for the private subnet

# Spin up Servers Resources

To create the server resources run the following command in the root folder of this repo: 

```bash
  ./create-stack.sh your-servers-stack-name servers.yml servers-params.json
```

The following server resources will be created:

- 1 User Role
- 2 Security Groups with inbound and outbound rules on port 80 ( 1 for the Load Balancer and 1 for the web servers)
- 1 AutoScalling Launch Configuration
- 1 AutoScalling Group which will spin up a min of **4 EC2 instances**
- 1 Target Group with a **health check** on port 80
- 1 Load Balancer 
- 1 Load balancer Listener 
- 1 Load Balancer Listener Rule

The EC2 instances can be customized in the servers-params.json file. Currently the EC2 instances are using an Ubuntu 16 AMI and are of t3.medium size. 

# The Running Web App

Each of the 4 running EC2 instances will be modeled based on the launch configuration which starts an apache server and downloads a demo app from an udacity S3 hosted static app. This is afterwards served from the www folder of the apache server. 
To access your app find the http URL of the Load Balancer in the outputs section of your servers stack in the CloudFormation console of your AWS Account:

![Running App](https://github.com/VeronicaM/infra-as-code/blob/master/launched_app.png)

# Customize for your own needs

To customize this to your own needs change the `WebAppLaunchConfig` resource in the `servers.yml` file. 
Once your are happy with the changes to the template file run the following command in the root folder of this repo:

```bash
  ./update-stack your-stack-name your-stack-template.yml your-stack-params.json
```

Please take notice of the charges a configuration of this size would bring and adjust it to your own application needs See https://aws.amazon.com/ec2/pricing/on-demand/ for more details on costs. 

Other Amazon resources might bring additional costs as well, for example the Load Balancer Health check and the Elastic IPs. Please make sure you are aware of all the involved costs before creating all these resources. Also if you do not need the resources running, make sure to delete your stack from the CloudFormation section. You can always easily bring it back by using runing the create-stack commands again. 
