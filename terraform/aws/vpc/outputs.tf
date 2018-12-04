output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "vpc_sg_id" {
  value = "${aws_vpc.main.default_security_group_id}"
}

output "default_sg_id" {
  value = "${aws_security_group.default.id}"
}
