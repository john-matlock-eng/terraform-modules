provider "aws" {
  region = "us-west-2"
}

# Test the default configuration
run "verify_default_configuration" {
  command = plan

  variables {
    repository_name = "test-lambda-repo"
    tags = {
      Environment = "test"
      Project     = "lambda-docker"
    }
  }
}

# Test invalid repository name
run "verify_invalid_repository_name" {
  command = plan

  variables {
    repository_name = "invalid@name"
    tags = {
      Environment = "test"
      Project     = "lambda-docker"
    }
  }
}

# Test tag propagation
run "verify_tag_propagation" {
  command = plan

  variables {
    repository_name = "test-lambda-repo"
    tags = {
      Environment = "test"
      CostCenter  = "123456"
      Project     = "terraform-testing"
    }
  }
}

# Test force delete configuration
run "verify_force_delete" {
  command = plan

  variables {
    repository_name = "test-lambda-repo"
    force_delete    = true
    tags = {
      Environment = "test"
      Project     = "lambda-docker"
    }
  }
}