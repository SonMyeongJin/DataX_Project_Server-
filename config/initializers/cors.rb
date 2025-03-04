Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Vue.js 개발 서버 주소
    resource '*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options],
      expose: ['Authorization'],
      credentials: true
  end
end
