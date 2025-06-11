provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "minecraft" {
  ami                    = "ami-0c101f26f147fa7fd"  # Amazon Linux 2023 in us-east-1
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/mnt/c/Users/olive/Downloads/awskey.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Instance is up and ready!'"
    ]
  }

  tags = {
    Name = "minecraft-server"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Instance ready'"]
  }
}

resource "aws_security_group" "minecraft_sg" {
  name_prefix = "minecraft-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["76.105.253.183/32"]
  }
  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
