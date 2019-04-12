variable region {
    default = "eu-central-1"
}

variable vpc {
    default = "vpc-874affef"
}

variable subnet {
    default = "subnet-87d3a6ef"
}

variable "image_id" {
    description = "The base image for your EC2 instance"
    default = "ami-090f10efc254eaf55"
}

variable bucket_id {
    description = "Supply a unique bucket ID"
}

variable create_bucket {
    description = "Set to 1 if you want to create a new bucket, otherwise 0."
    default = 1
}

variable instance_size {
    default = "t3.medium"
}

variable tags {
    description = "Use your preferred choice of tags to keep track of your services. These are just an example."
    default = {
        Owner = "Kurt Vooys"
        Type = "NWM"
        Terraform = "True"
    }
}