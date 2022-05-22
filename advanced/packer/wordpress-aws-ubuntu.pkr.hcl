packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-wordpress-tutorialinux-aws"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  temporary_key_pair_type = "ed25519"
}

build {
  name    = "packer-wordpress-tutorialinux-aws"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    scripts = [
      # base install
      "scripts/ami_config_script.sh"
    ]
    # TODO do we need the new php.ini from https://github.com/groovemonkey/hands_on_linux-self_hosted_wordpress_for_linux_beginners/blob/master/5-basic-phpfpm-and-php-configuration.md

    # TODO mysql secure install: https://github.com/groovemonkey/hands_on_linux-self_hosted_wordpress_for_linux_beginners/blob/master/6-set-up-mysql-database.md
  }
  provisioner "file" {
    source = "./config/nginx.conf"
    destination = "~/nginx.conf"
  }
  provisioner "file" {
    source = "./config/wordpress_nginx.conf"
    destination = "~/wordpress_nginx.conf"
  }
  provisioner "file" {
    source = "config/wordpress_phpfpm.conf"
    destination = "~/phppool.conf"
  }
  provisioner "shell" {
    # copying files in two steps because of packer/sudo limitations
    inline = [
      "sudo mv ~/nginx.conf /etc/nginx/nginx.conf",
      "sudo mv ~/wordpress_nginx.conf /etc/nginx/conf.d/tutorialinux.conf",
      "sudo mv ~/phppool.conf /etc/php/8.1/fpm/pool.d/tutorialinux.conf",
    ]
  }
  provisioner "shell" {
    scripts = [
      # final WordPress application setup
      "scripts/wordpress_site_setup.sh"
    ]
  }

}
