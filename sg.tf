# Create security group for Public

resource "aws_security_group" "alb_public" {
  count       = var.INTERNAL ? 0 : 1
  name        = "robot-${var.ENV}-public-alb-sg"
  description = "Allow Public traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description      = "Allows HTTP Traffic from Public"
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

# Create security group private

resource "aws_security_group" "alb_private" {
  count       = var.INTERNAL ? 1 : 0
  name        = "robot-${var.ENV}-private-alb-sg"
  description = "Allow Private traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description      = "Allows HTTP Traffic from Internal Traffic only"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["data.terraform_remote_state.vpc.outputs.VPC_CIDR"]
  }

  tags = {
    Name = "robot-${var.ENV}-private-alb-sg"
  }
}