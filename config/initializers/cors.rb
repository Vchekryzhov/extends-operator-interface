Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ['http://dimapriv.ru', 'http://localhost:3000']
    resource '*', credentials: true, headers: :any, methods: %i(get post put patch delete options head)
  end
end
