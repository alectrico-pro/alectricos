class SandboxEmailInterceptor
  
  def self.delivering_email(message)
    extend Linea

    if ( Rails.env.production? or Rails.env.aelectrico ) \
      and (ENV['INTERCEPTAR'] == 'SI')
      linea.info "Interceptando #{message.to}"
      message.to = ['interceptado@alectrico.cl']
    end
  end

end
