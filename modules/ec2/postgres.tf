resource "aws_security_group" "postgres_sg" {
  description = "Allow Postgres from EKS nodes"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH access from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    description     = "Postgres access from EKS nodes"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.eks_cluster_sg_id]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}

resource "aws_instance" "postgres" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = var.private_subnet
  key_name      = aws_key_pair.bastion_ssh.key_name

  vpc_security_group_ids = [aws_security_group.postgres_sg.id]

  user_data = <<EOF
#!/bin/bash
apt-get update
apt-get install ansible -y
EOF

  tags = merge(var.tags, {
    Name = "${var.project_name}-postgres"
  })
}
