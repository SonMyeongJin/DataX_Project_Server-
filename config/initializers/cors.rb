Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # 모든 도메인 허용 (보안이 필요하면 '*' 대신 'http://localhost:8080' 사용)
    resource '*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options],
      expose: ['Authorization']
  end
end
