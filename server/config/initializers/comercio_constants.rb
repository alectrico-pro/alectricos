#KHIPU YA NO OFRECE ESTE SERVICIO
#KHIPU_SANDBOX = ENV['KHIPU_MODE'] ? (ENV['KHIPU_MODE'] == "sandbox") : false
#if KHIPU_SANDBOX
#KHIPU_CONFIG = YAML::load(ERB.new(File.read(Rails.root.join("config","khipu.yml"))).result)['sandbox']
#else
#  KHIPU_CONFIG = YAML::load(ERB.new(File.read(Rails.root.join("config","khipu.yml"))).result)[Rails.env]
#end

#KHIPU_CLIENTE_ID  = KHIPU_CONFIG["cliente_id"]
#KHIPU_CLIENTE_KEY = KHIPU_CONFIG["cliente_key"]



#PAYPAL

#PAYPAL_SANDBOX = ENV['PAYPAL_MODE'] ? ENV['PAYPAL_MODE'] == "sandbox" : false
#if PAYPAL_SANDBOX
#  PayPal::SDK.load("config/paypal.yml", 'development')
#else
#  PayPal::SDK.load("config/paypal.yml", Rails.env)
#end
#PayPal::SDK.logger = Rails.logger

