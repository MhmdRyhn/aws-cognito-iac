// NOTE: How will a user be able to recover their account?
// This option under `MFA and verifications` is not supported yet in terraform.
// An issue has been raised in github and it's still open.
// https://github.com/terraform-providers/terraform-provider-aws/issues/11220

// WARNING: Don't use `provisioner "local-exec"{}` to set account recovery mechanism.
// It'll wipe out the whole configuration.
// You can manually update this option after the orchastration of your resources.
// It'll be better than using `provisioner "local-exec"{}`.

resource "aws_cognito_user_pool" "terrapool" {
  # Cognito: What do you want to name your user pool?
  name = "${local.prefix}-${var.user_pool_name}"

  # Cognito: How do you want your end users to sign in?
  username_attributes = ["email"]

  # Cognito: (Recommended) Enable case insensitivity for username input
  username_configuration {
    case_sensitive = false
  }

  # Cognito: What password strength do you want to require?
  password_policy {
    minimum_length                   = 6
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  # Cognito: Do you want to allow users to sign themselves up?
  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  # Cognito: Which standard attributes do you want to require?
  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    // Allow users to update the field's value
    mutable = true
  }

  # Cognito: Which attributes do you want to verify?
  auto_verified_attributes = ["email"]

  # Cognito: Do you want to customize your email verification messages?
  verification_message_template {
    # All are default value
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Your verification code"
    email_message        = "Your verification code is {####}"
  }

  # Cognito: Do you want to add tags for this user pool?
  tags = {
    Name        = "${local.tag_prefix}:${var.user_pool_name}"
    Environment = var.environment
  }
}


resource "aws_cognito_user_pool_client" "client" {
  # Cognito: User Pool ID
  user_pool_id = aws_cognito_user_pool.terrapool.id

  # Cognito: App client name
  name = var.app_client_name

  # Cognito: Refresh token expiration (days)
  refresh_token_validity = 30

  # Cognito: [x] Generate client secret
  generate_secret = false // Don't create client Secret along with the Id.

  # Cognito: Auth Flows Configuration
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_CUSTOM_AUTH"
  ]

  # Cognito: Prevent User Existence Errors
  prevent_user_existence_errors = "ENABLED"
}
