Devise.setup do |config|
  # JWT 인증 설정
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.secret_key_base
    jwt.dispatch_requests = [['POST', %r{^/users/sign_in$}]]
    jwt.revocation_requests = [['DELETE', %r{^/users/sign_out$}]]
    jwt.expiration_time = 1.day.to_i
  end

  config.secret_key = Rails.application.credentials.secret_key_base
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

  require "devise/orm/active_record"

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.params_authenticatable = true
  config.skip_session_storage = [:http_auth]

  # Devise가 HTML 응답을 시도하지 않도록 설정
  config.navigational_formats = []

  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.sign_out_via = :delete
  config.reconfirmable = true

  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
  config.remember_for = 2.weeks
  config.expire_all_remember_me_on_sign_out = true
end
