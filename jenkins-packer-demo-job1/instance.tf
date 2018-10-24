resource "aws_instance" "example" {
  ami           = "${var.APP_INSTANCE_AMI}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.example-instance.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}

output "ip" {
    value = "${aws_instance.example.public_ip}"
}