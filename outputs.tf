output "ec2_public_ip" {
    value = "${aws_instance.Your-EC2.public_ip}"
}