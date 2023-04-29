# Creates SG for Public ALB
resource "aws_security_group" "alb_public" {
  count              = var.INTERNAL ? 0 : 1

  name               = "robot-${var.ENV}-public-alb-sg"
  description        = "Allows Public Traffic"
  vpc_id             = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description      = "Allows HTTP Traffic From Public"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "robot-${var.ENV}-public-alb-sg"
  }
}

# Creates SG for Private ALB
resource "aws_security_group" "alb_private" {
  count              = var.INTERNAL ? 1 : 0

  name               = "robot-${var.ENV}-private-alb-sg"
  description        = "Allows Internal Traffic"
  vpc_id             = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description      = "Allows HTTP Traffic From Intrenal Network Only"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "robot-${var.ENV}-private-alb-sg"
  }
}