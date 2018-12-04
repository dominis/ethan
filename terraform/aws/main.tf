terraform {
  required_version = ">= 0.11.0"
}

provider "aws" {
  region = "us-east-1"
}

module "analyzer" {
  source = "analyzer"
}

module "profiler-us-east-1" {
  source         = "profiler"
  region         = "us-east-1"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-us-east-2" {
  source         = "profiler"
  region         = "us-east-2"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-us-west-1" {
  source         = "profiler"
  region         = "us-west-1"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-us-west-2" {
  source         = "profiler"
  region         = "us-west-2"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-ca-central-1" {
  source         = "profiler"
  region         = "ca-central-1"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-eu-central-1" {
  source         = "profiler"
  region         = "eu-central-1"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-eu-west-1" {
  source         = "profiler"
  region         = "eu-west-1"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-eu-west-2" {
  source         = "profiler"
  region         = "eu-west-2"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-eu-west-3" {
  source         = "profiler"
  region         = "eu-west-2"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-ap-northeast-1" {
  source         = "profiler"
  region         = "ap-northeast-1"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-ap-northeast-2" {
  source         = "profiler"
  region         = "ap-northeast-2"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-ap-northeast-3" {
  source         = "profiler"
  region         = "ap-northeast-2"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-ap-southeast-1" {
  source         = "profiler"
  region         = "ap-southeast-1"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-ap-southeast-2" {
  source         = "profiler"
  region         = "ap-southeast-2"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-ap-south-1" {
  source         = "profiler"
  region         = "ap-south-1"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}

module "profiler-sa-east-1" {
  source         = "profiler"
  region         = "sa-east-1"
  redis_password = "${module.analyzer.redis_password}"
  redis_host     = "${module.analyzer.redis_host}"
  ssh_key        = "${var.ssh_key}"
  test_host      = "${var.test_host}"
}
