provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "jenkins-ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Jenkins-Image*"]
  }

  owners = [var.aws_account_owner]
}

resource "aws_key_pair" "dsw-key" {
  key_name   = "dsw-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCh3ZZvWomgbzmL0lLnWyqQZEHEXeAZXccfkBr1rq27yw35Z/Hdc0tvbhJEBpa3YBi8vLZ0SlSVl/xRc99U8a0AhsJoDXxV14xgVJQppgLQLAiV+lHRN4S0FJvIqNZxJ2dqFxttGpkke34yxWCM+by1ygnbnZQEfPbynLpd3oO7YN1ctY87y8ONXmTIqE50zpBNuaI7AVNI2qzuoAhUwvUlX0xKMrFc0jssLJzxusvcyq+Q6yVdqmKD6+43WlOb2qTYiRYIAPCiN5lmRb3h/eOOhQJMF+3qd3ivKImKV/Xz8LOUkiZcXZ2ZmiOYdYrfqR5iGyvP0DOkFvSYxogoVSlN github_account"
}

resource "aws_instance" "webserver" {
  ami           = "${data.aws_ami.jenkins-ami.id}"
  instance_type = "t2.micro"
  /*iam_instance_profile = var.iam_role*/
  key_name = "dsw-key"
  security_groups = [
    var.my_security_group
  ]
  tags = {
    Name  = "Jenkins Server"
    owner = var.owner
  }
}
