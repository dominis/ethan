module "vpc" {
  source = "../vpc"
  region = "${var.region}"
  name   = "ethan-profiler"
}

resource "aws_key_pair" "defaultkey" {
  key_name   = "defaultkey"
  public_key = "${var.ssh_key}"
}

resource "aws_instance" "node" {
  count                  = "${length(data.aws_availability_zones.available.names) * var.servers_per_az}"
  instance_type          = "${var.instance_type}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "defaultkey"
  subnet_id              = "${element(module.vpc.public_subnet_ids, count.index)}"
  vpc_security_group_ids = ["${module.vpc.default_sg_id}"]

  provisioner "file" {
    source      = "../../profiler.py"
    destination = "/home/ubuntu/profiler.py"

    connection {
      type = "ssh"
      user = "ubuntu"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y python-numpy python-redis",
      "az=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone/` ; echo export AVAILABILITY_ZONE=$az >> /home/ubuntu/.config",
      "echo 'export REDIS_PASSWORD=${var.redis_password}' >> /home/ubuntu/.config",
      "echo 'export REDIS_HOST=${var.redis_host}' >> /home/ubuntu/.config",
      "echo 'export TEST_HOST=${var.test_host}' >> /home/ubuntu/.config",
      "echo 'export TEST_COUNT=${var.test_count}' >> /home/ubuntu/.config",
      "bash -c 'source /home/ubuntu/.config ; python /home/ubuntu/profiler.py'",
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
    }
  }

  tags = {
    Name = "ethan-profiler-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}
