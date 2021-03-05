variable "app_name" {
  type        = string
  description = "Application name to give your schema migrations lambda function (e.g. hello-world-dev)"
}

variable "migration_files" {
  type        = string
  description = "Path and pattern to enumerate the schema migration files (e.g. ./migrations/dir/*.sql)"
}

variable "migrations_bucket_name" {
  type        = string
  description = "The name of the S3 Bucket name where this module will upload the schema migrations directory (defaults to <app_name>-schema-migrations)"
  default     = null
}

variable "database" {
  type = object({
    identifier = string
    username   = string
    password   = string
    name       = string
  })
  description = "The RDS database connection information"
  sensitive   = true
}

variable "role_permissions_boundary_arn" {
  type        = string
  description = "ARN of the IAM Role permissions boundary to place on each IAM role created."
}

variable "log_retention_in_days" {
  type        = number
  description = "CloudWatch log group retention in days. Defaults to 7."
  default     = 7
}

variable "tags" {
  type        = map(string)
  description = "A map of AWS Tags to attach to each resource created"
  default     = {}
}

variable "memory_size" {
  type        = number
  description = "the size of memory for the lambda"
  default     = 128
}

variable "timeout" {
  type        = number
  description = "the amount of time the lambda is allowed to run for"
  default     = 30
}
