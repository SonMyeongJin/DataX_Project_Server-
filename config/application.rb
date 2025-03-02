require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module BlogApp
  class Application < Rails::Application
    config.load_defaults 7.2

    # API 모드 설정 (뷰 렌더링이 필요 없을 경우 활성화)
    config.api_only = true

    # CORS 설정 (Vue.js에서 요청 가능하도록 허용)
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:8080'  # Vue.js 개발 서버
        resource '*',
          headers: :any,
          methods: [:get, :post, :patch, :put, :delete, :options],
          expose: ['Authorization'],
          credentials: true
      end
    end

    # 세션 및 쿠키 지원 (JWT 인증 시 필요)
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.middleware.use Rack::MethodOverride

    # 디버깅을 위한 로깅 설정
    config.log_level = :debug
  end
end
