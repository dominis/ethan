output "redis_password" {
  value = "${random_string.redis_password.result}"
}

output "redis_host" {
  value = "${aws_instance.analyzer.public_dns}"
}
