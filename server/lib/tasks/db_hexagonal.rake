#Para migrar
##rails hexagonal:db:migrate
##Para generar 
##rails g hexagonal_migration
#

task spec: ["hexagonal:db:test:prepare"]

namespace :hexagonal do

  namespace :db do |ns|

    namespace :seed do |ns_seed|
      desc "Dump records for electrico into db_hexagonal/seeds.rb"
      task :dump => :environment do
	SeedDump.dump_using_environment(ENV)
##eedDump.dump_using_environment('development')

      end
    end
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

    namespace :migrate do
      task :redo do
        Rake::Task["db:migrate:redo"].invoke
      end
      task :status do
	Rake::Task["db:migrate:status"].invoke
      end
    end
    
    task :rollback do
      Rake::Task["db:rollback"].invoke
    end

    task :seed do
      Rake::Task["db:seed"].invoke
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
      task.enhance ["hexagonal:set_custom_config"] do
        Rake::Task["hexagonal:revert_to_original_config"].invoke
      end
    end
  end

  task :set_custom_config do
    # save current vars
    @original_config = {
      env_schema: ENV['SCHEMA'],
      config: Rails.application.config.dup
    }

    # set config variables for custom database, esto es para el dump
    ENV['SCHEMA'] = "db_hexagonal/schema.rb"
    ENV['FILE']   = "db_hexagonal/seeds.rb"
    ENV['MODEL']  = "Hexagonal::Order"
    ENV['EXCLUDE'] = "id"



    Rails.application.config.paths['db'] = ["db_hexagonal"]
    Rails.application.config.paths['db/migrate'] = ["db_hexagonal/migrate"]
    Rails.application.config.paths['db/seeds.rb'] = ["db_hexagonal/seeds.rb"]
    Rails.application.config.paths['config/database'] = ["config/database_hexagonal.yml"]
  end

  task :revert_to_original_config do
    # reset config variables to original values
    ENV['SCHEMA'] = @original_config[:env_schema]
    Rails.application.config = @original_config[:config]
  end
end
