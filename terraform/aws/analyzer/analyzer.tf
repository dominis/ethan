resource "random_string" "redis_password" {
  length  = 128
  special = false
  upper   = true
  lower   = true
  number  = true
}

resource "aws_instance" "analyzer" {
  instance_type   = "${var.instance_type}"
  ami             = "${data.aws_ami.ubuntu.id}"
  key_name        = "defaultkey"
  security_groups = ["${aws_security_group.default.name}"]

  tags = {
    Name = "ethan-analyzer"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y redis-server python-numpy python-redis",
      "sudo bash -c 'echo requirepass ${random_string.redis_password.result} >> /etc/redis/redis.conf'",
      "sudo bash -c 'echo bind 0.0.0.0 >> /etc/redis/redis.conf'",
      "sudo service redis-server stop",
      "sudo service redis-server start",
      "sudo service redis-server status",
      "echo 'export REDIS_PASSWORD=${random_string.redis_password.result}' >> /home/ubuntu/.config",
      "echo 'export REDIS_HOST=127.0.0.1' >> /home/ubuntu/.config",
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
    }
  }
}

resource "aws_security_group" "default" {
  # TODO remove this
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
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
