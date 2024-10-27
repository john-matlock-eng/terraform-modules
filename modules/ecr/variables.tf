variable "repository_name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "image_tag_mutability" {
  type        = string
  description = "Image tag mutability setting. Either MUTABLE or IMMUTABLE"
  default     = "IMMUTABLE"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Image tag mutability must be either MUTABLE or IMMUTABLE"
  }
}

variable "scan_on_push" {
  type        = bool
  description = "Enable scan on push for the repository"
  default     = true
}

variable "force_delete" {
  type        = bool
  description = "Force deletion of the repository even if it contains images"
  default     = false
}

variable "lifecycle_policy" {
  type = object({
    rules = list(object({
      rulePriority = number
      description  = string
      selection = object({
        tagStatus     = string
        countType     = string
        countNumber   = number
        countUnit     = optional(string)
        tagPrefixList = optional(list(string))
      })
      action = object({
        type = string
      })
    }))
  })
  description = "Lifecycle policy for the ECR repository"
  default = {
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 30 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for ECR encryption. Leave empty to use the default AWS-managed key."
  type        = string
  default     = ""
}
