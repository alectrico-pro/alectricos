# Load the Rails application.
require_relative 'application'



#Parche para esolver un error de formatter= ocasionado por Webpacker

module Logging
  module RailsCompat
    def tagged(*args); yield; end
  end
end

module ActiveJob
  module Logging
    private

    def tag_logger(*tags)
      yield
    end
  end
end
# Initialize the Rails application.
Rails.application.initialize!
