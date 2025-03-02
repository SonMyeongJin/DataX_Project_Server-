# config/initializers/devise.rb

# Devise 기본 설정
Devise.setup do |config|
  # JWT 설정 (인증 및 로그인 관련 설정)
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.secret_key_base
    jwt.dispatch_requests = [
      ['POST', %r{^/users/sign_in$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/users/sign_out$}]
    ]
    jwt.expiration_time = 1.day.to_i
  end

  # The secret key used by Devise. Devise uses this key to generate
  # random tokens. Devise will use the `secret_key_base` as its `secret_key`
  # by default.
  config.secret_key = Rails.application.credentials.secret_key_base

  # Configure the e-mail address which will be shown in Devise::Mailer,
  # note that it will be overwritten if you use your own mailer class
  # with default "from" parameter.
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

  # Configure the ORM. Default is :active_record (Rails)
  require "devise/orm/active_record"

  # Case insensitivity for email
  config.case_insensitive_keys = [ :email ]

  # Strip whitespace from email
  config.strip_whitespace_keys = [ :email ]

  # Allow params-based authentication
  config.params_authenticatable = true

  # Store session data for authentication (default session storage)
  config.skip_session_storage = [ :http_auth ]

  # Configure the strategies and mappings for Devise
  config.navigational_formats = [ :json ]

  # Password configurations
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # Allow user to sign out via DELETE request
  config.sign_out_via = :delete

  # Enable the confirmation email flow
  config.reconfirmable = true

  # Default error status and redirects for Hotwire/Turbo
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  # Configure the duration for remembering users
  config.remember_for = 2.weeks
  config.expire_all_remember_me_on_sign_out = true
end
