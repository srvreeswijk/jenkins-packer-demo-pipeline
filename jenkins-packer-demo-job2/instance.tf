resource "aws_instance" "app-instance" {
  count = "${var.APP_INSTANCE_COUNT}"
  ami = "${var.APP_INSTANCE_AMI}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.app-securitygroup.id}"]

}
