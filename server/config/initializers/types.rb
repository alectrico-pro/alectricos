#Esto cargas los interceptores que ahora viven en lib y otros tipos
Dir[Rails.root.join('lib', 'interceptors', '**', '*.rb')].each { |f| require f }
ActionMailer::Base.register_interceptor(::SandboxEmailInterceptor)

#ctiveRecord::Type.register(:example, Example)
