require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gancho
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0


    config.add_autoload_paths_to_load_path = false
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.log_to = %w[stdout file email]
    config.domain = config_for(:domain) #Carga el achivo domain.yml para configuraciones mias
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
      g.test_framework :test_unit, fixture: false
  g.test_framework :rspec
  g.helper_specs false
  g.controller_specs true
  g.view_specs false
  g.routing_specs true
  g.request_specs true
      g.stylesheets false #usdo form_for sobrecargado con bootstrap_builder
      g.javascripts false
      g.helper :sidebar
      g.helper :panel
      g.helper :item
    end

    config.time_zone = "Santiago"
    config.active_record.default_timezone = :local #debe usarse utc en production
    config.active_record.time_zone_aware_attributes = false #debe ser true en production

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

    config.i18n.default_locale = :es_Cl


    config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"


  end

end
