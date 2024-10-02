resource "aws_key_pair" "placeholder_key" {
  key_name   = "placeholder-do-not-use-this-key-to-login-we-do-not-have-it-saved-anywhere"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG8NPJy09zY05w/bCAPodtdcSk4/DZtldqs1pQIAPRrG your_email@example.com"
}

resource "aws_launch_template" "full_example" {
  name                   = "cloud-developer-environment"
  description            = "Launch a cloud developer environment"
  update_default_version = true

  instance_type = "t3a.xlarge"
  key_name      = aws_key_pair.placeholder_key.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.cloud-developer-environments.id]
    subnet_id                   = module.subnets.public_subnet_ids[0]
  }


  metadata_options {
    http_endpoint = "enabled"
  }



  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "@glueops.dev"
    }
  }

  #   user_data = base64encode("echo 'Hello, World!' > /var/tmp/hello.txt") # Example user data script
}
