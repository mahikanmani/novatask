resource "aws_instance" "monitor-server" {
  ami           = "ami-04f167a56786e4b09"
  instance_type = var.instance_type
  key_name = var.key_name


  tags = {
    Name = "monitor-server"
  }

  user_data = file("${path.module}/scripts/install_prometheus.sh")
}


