Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://54.180.239.200' # Vue.js 개발 서버 주소
    resource '*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options],
      expose: ['Authorization'],
      credentials: true
  end
end
