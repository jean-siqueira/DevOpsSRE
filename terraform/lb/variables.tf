variable "region" {
  type = string
  default = "us-east-1"

}
variable "vpc_id" {
  type = string
  default = "vpc-0fc9e48108b5c0ef7"
}

variable "subnets" {
    type = list
    default = ["subnet-09efc37e347597548", "subnet-0870b8b1912d693da"]
  
}

variable "instance_id" {

    type = string
    default = "i-042c5a7a856f970bf"
  
}








