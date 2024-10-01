# Create EC2 instance in Public Subnet
resource "aws_instance" "web_server_a" {
  ami                         = "ami-0d53d72369335a9d6" 
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_a.id
  key_name                    = "optisol"  # Replace with your key pair name
  security_groups             = [aws_security_group.public_sg.id]

  tags = {
    Name = "WebServer1"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "Hello, World!" > /var/www/html/index.html
            EOF
}
resource "aws_instance" "web_server_b" {
  ami                         = "ami-0d53d72369335a9d6" 
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_b.id
  key_name                    = "optisol"  # Replace with your key pair name
  security_groups             = [aws_security_group.public_sg.id]

  tags = {
    Name = "WebServer2"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "Hello, World!" > /var/www/html/index.html
            EOF
}

