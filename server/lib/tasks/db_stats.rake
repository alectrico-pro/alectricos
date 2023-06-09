#Para migrar
##rails stats:db:migrate
##Para generar 
##rails g stats_migration
# Se usa para guardar estadísticas en otras bases de datos que no estén en producción. Por ejmplo para resguardar las preguntas que se han ido generando
task spec: ["stats:db:test:prepare"]

namespace :stats do

  namespace :db do |ns|

    task :drop do
      Rake::Task["db:drop"].invoke
    end

    task :create do
      Rake::Task["db:create"].invoke
    end

    task :setup do
      Rake::Task["db:setup"].invoke
    end

    task :migrate do
      Rake::Task["db:migrate"].invoke
    end

    task :rollback do
      Rake::Task["db:rollback"].invoke
    end
    namespace :seed do |ns_seed|
      desc "Dump records for electrico into db_electrico/seeds.rb"
      task :dump => :environment do
#        SeedDump.dump_using_environment(ENV)
        SeedDump.dump_using_environment('heroku')
      end
    end

    task :version do
      Rake::Task["db:version"].invoke
    end

    namespace :schema do
      task :load do
        Rake::Task["db:schema:load"].invoke
      end

      task :dump do
        Rake::Task["db:schema:dump"].invoke
      end
    end

    namespace :test do
      task :prepare do
        Rake::Task["db:test:prepare"].invoke
      end
    end

    # append and prepend proper tasks to all the tasks defined here above
    ns.tasks.each do |task|
      task.enhance ["stats:set_custom_config"] do
        Rake::Task["stats:revert_to_original_config"].invoke
      end
    end
  end

  task :set_custom_config do
    # save current vars
    @original_config = {
      env_schema: ENV['SCHEMA'],
      config: Rails.application.config.dup
    }

    # set config variables for custom database
    ENV['SCHEMA'] = "db_stats/schema.rb"
    Rails.application.config.paths['db'] = ["db_stats"]
    Rails.application.config.paths['db/migrate'] = ["db_stats/migrate"]
    Rails.application.config.paths['db/seeds'] = ["db_stats/seeds.rb"]
    Rails.application.config.paths['config/database'] = ["config/database_stats.yml"]
  end

  task :revert_to_original_config do
    # reset config variables to original values
    ENV['SCHEMA'] = @original_config[:env_schema]
    Rails.application.config = @original_config[:config]
  end
end
