Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://54.180.239.200'  # * 대신 특정 출처 지정
    resource '*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options],
      expose: ['Authorization'],
      credentials: true  # true로 변경
  end
end
