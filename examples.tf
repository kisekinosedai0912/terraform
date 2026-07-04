# Blocks
# blocks are containers that contains other blocks as well that defines its representation such as 
# provider, resource, data, variable, output, module, terraform, locals, backend, check & import

terraform {
	# required providers block declares all the possible providers that your infra may use
	required_providers {
		vercel = {
			source = "vercel/vercel"
			version = ">= 4.8"
		}
		aws = {
			source = "hashicorp/aws"
			version = "~> 6.0"		
		}
	}
}

# variable blocks define the type of value your variable will hold instead of hardcoding it
variable "vercel_api_token" {
	description = "vercel's api token provided to connect and initiate vercel settings configurations"
	type = string
}

variable "team_slug" {
	description = "the team's vercel organization A.K.A 'uplow'"
	type = string
}

# block provider declares the provider configuration that you are going to use from your dceclared
# required providers block
provider "vercel" {
	api_token = var.vercel_api_token
	team = var.team_slug
}

provider "aws" {
	region = "us-east-1"
}

# resource block defines the type of resource that you will use that your provider provides
# e.g. AWS provides vpc, s3 bucket, EC2, ECS & etc.
resource "aws_vpc" "uplow_vpc" {
	cidr_block = "10.0.0.0/16"
}

# data types
# similar to programming languages, HCL also has data types which are
# string, boolean, number, list, set, map, object & tuple

# list
variable "string_list" {
	type = list(string)
	default = [ "dev", "staging", "production" ]
}

# you can define a list with its type specific data type similar to typescript
# e.g. let myArr: string[] = ['string1', 'string2'] or let myArr: number[] = [0, 1, 2]
variable "number_list" {
  	type = list(number)
	default = [ 0, 1, 2 ]
}

# locals is a block which contains all your local variables
# locals contains the values that you assign to your attribute which is different than variables
# variables are the validation schema of your data type similar to zod/typescript types
locals {
	# map
	# assigning maps is similar to declaring an object in javascript/typescript
	example_map = {
		id: 1,
		name: "John Doe"
		email: "dev@uplow.com"
	}
	example_string_list = ["item1", "item2"]
	example_number_list = [0, 1, 2]
}

/*
	NOTE: use variables when you use a confidential values liek api keys, connection string 
	& etc. because variables are being injected during run time similar to how env variables work.

	Use locals when you want to use local values in your code that isn't critical/confidential
	which is allowed values to be seen publicly
*/

# attributes
# attributes are the key = value pair of your declared block, variable, locals and etc.
# you can only use attributes inside a block
# example -> type = string, default = ["item"], isBool = true

variable "environment" {
	description = "the environment of the current infrastructure deployed to use"
	type = string
}

# conditions
# writing condition statements is similar to how you write ternary operators in js/ts
# useful when you want your infra code to adjust dynamically on your environment
resource "aws_instance" "uplow_instance" {
	instance_type = var.environment == "dev" ? "t2.micro" : "staging" ? "t2.medium" : "t2.small"
}

# functions
# functions here in TF are similar to methods in javascript which are built in values of HCL
# these functions are used to alter your data values dynamically, below samples:

# numeric functions
locals {
	value = 10
	stringValue = "10"
	calculations = {
		roundUp: ceil(local.value)
		roundDown: floor(local.value)
		convertToInt = parseint(local.stringValue)
		# and etc.
	}
}

# string functions
locals {
	stringArr = ["banana", "apple", "mango"]
	singleString = "omnipotent"
	methods = {
		stringJoin: join(",", local.stringArr)
		stringSplit: split(",", local.singleString)
		stringReplace: replace("${local.methods["stringSplit"]}", ",", "")
		# and etc.
	}
}

# more functions are present in the documentation

# resource dependency
# explicit resource dependency 
# explicitly define resources that your other resource uses is valid while TF also provides
# some of this resource dependency implicitly by default
# e.g. cidr_block = "10.0.0.0/16" and etc
resource "aws_instance" "name" {
	vpc_security_group_ids = aws_security_group.aws_sg
}

resource "aws_security_group" "aws_sg" {
	# define security group configurations here
}