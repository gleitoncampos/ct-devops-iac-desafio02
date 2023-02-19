module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.vpc_name}_1"
  cidr = var.vpc_cidr

  azs                  = var.vpc_azs
  private_subnets      = var.vpc_private_subnets
  public_subnets       = var.vpc_public_subnets
  enable_dns_hostnames = true

  tags = {
    Terraform   = true
    Environment = "dev"
  }
}

resource "aws_eip_association" "wordpress_eip_asso" {
  instance_id   = aws_instance.wordpress.id
  allocation_id = var.wp_eip
}
module "instance_securitygroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "wordpress-sg"
  description = "Security group for wordpress"
  vpc_id      = module.vpc.vpc_id
  
  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "ssh-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "http-8080-tcp",
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

resource "aws_instance" "wordpress" {
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = ["${module.instance_securitygroup.security_group_id}"]
  associate_public_ip_address = true
  key_name = var.aws_keyname
  user_data = templatefile("./userdata.sh", {})
  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file(var.aws_keypath)
      host = aws_instance.wordpress.public_ip
    }

  provisioner "file" {
    source = "./docker-compose.yml"
    destination = "/home/ubuntu/docker-compose.yml"
  }
  provisioner "remote-exec" {
    inline = [
      "echo WP_MYSQL_DB_NAME=${var.wp_mysql_db_name}>>~/.env",
      "echo WP_MYSQL_DB_USER=${var.wp_mysql_db_user}>>~/.env",
      "echo WP_MYSQL_DB_PASS=${var.wp_mysql_db_pass}>>~/.env",
    ]
  }

  tags = {
    "Name" = "Wordpress"
    Terraform = true
  }
  depends_on = [
    module.instance_securitygroup,
    module.vpc
  ]
}

resource "aws_volume_attachment" "wordpress_ebs_att" {
  device_name = "/dev/xvdw"
  volume_id   = var.ebs_id
  instance_id = aws_instance.wordpress.id 
  stop_instance_before_detaching = true 
}