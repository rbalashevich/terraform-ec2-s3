resource "aws_instance" "docker1" {
  ami           = var.AMI
  instance_type = "t3.micro"
  # VPC
  subnet_id = aws_subnet.prod-subnet-public-1.id
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
  # the Public SSH key
  key_name = aws_key_pair.ec2-key-pair.id
  # docker installation with user_data
  user_data            = file("userdata.sh")
  iam_instance_profile = aws_iam_instance_profile.some_profile.id

  connection {
    user        = var.EC2_USER
    private_key = file("${var.PRIVATE_KEY_PATH}")
  }
}
// Sends your public key to the instance
resource "aws_key_pair" "ec2-key-pair" {
  key_name   = "ec2-key-pair"
  public_key = file(var.PUBLIC_KEY_PATH)
}

output "ec2_global_ips" {
  value = ["${aws_instance.docker1.*.public_ip}"]
}
