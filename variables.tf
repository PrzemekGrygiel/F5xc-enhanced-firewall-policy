

variable "f5xc_nfv_name" {
  type = string
}

variable "f5xc_aws_vpc_attachment_ids" {
  type = list(string)
}
variable "f5xc_aws_vpc_prefixes" {
  type = list(string)
}

variable "public_ips" {
  type = list(string)
}
variable "remote_ips" {
  type = list(string)
}