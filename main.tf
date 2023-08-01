provider "aws" {
  region = "us-west-2"  # Replace with your desired region
}

resource "aws_vpc" "jenkins_vpc" {
  cidr_block = "10.1.0.0/16"  # Replace with your desired CIDR block

  tags = {
    Name = "jenkins-vpc"  # Replace with your desired VPC name
  }
}

resource "aws_subnet" "my_subnet_1" {
  cidr_block = "10.1.1.0/24"
  vpc_id     = aws_vpc.jenkins_vpc.id
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-subnet-1"
  }
}

resource "aws_internet_gateway" "jenkins_igw" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Name = "jenkins-igw"  # Replace with your desired Internet Gateway name
  }
}

resource "aws_route_table" "pub_rt" {    #public route table
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Name = "pub-rt"  # Replace with your desired Route Table name
  }
}

resource "aws_route" "my_route" {
  route_table_id = aws_route_table.pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.jenkins_igw.id
}

resource "aws_route_table_association" "my_rta_1" {
  subnet_id      = aws_subnet.my_subnet_1.id
  route_table_id = aws_route_table.pub_rt.id
}

