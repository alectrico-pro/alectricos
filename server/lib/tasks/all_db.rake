desc "all:db:test:prepare"
namespace :all do
  namespace :db do
    task :drop do
      Rake::Task["electrico:db:drop"].invoke
      Rake::Task["gestion:db:drop"].invoke
      Rake::Task["comercio:db:drop"].invoke
      Rake::Task["cargas:db:drop"].invoke
    end
    task :create do
      Rake::Task["electrico:db:create"].invoke
      Rake::Task["gestion:db:create"].invoke
      Rake::Task["comercio:db:create"].invoke
      Rake::Task["cargas:db:create"].invoke
    end
    task :setup do
      Rake::Task["electrico:db:setup"].invoke
      Rake::Task["gestion:db:setup"].invoke
      Rake::Task["comercio:db:setup"].invoke
      Rake::Task["cargas:db:setup"].invoke
    end
    task :migrate do
      Rake::Task["electrico:db:migrate"].invoke
      Rake::Task["gestion:db:migrate"].invoke
      Rake::Task["comercio:db:migrate"].invoke
      Rake::Task["cargas:db:migrate"].invoke
    end
    task :seed do
      Rake::Task["electrico:db:seed"].invoke
      Rake::Task["gestion:db:seed"].invoke
      Rake::Task["comercio:db:seed"].invoke
     # Rake::Task["cargas:db:seed"].invoke
    end

    namespace:seed do
     task :dump do
       Rake::Task["electrico:db:seed:dump"].invoke
       Rake::Task["gestion:db:seed:dump"].invoke
       Rake::Task["comercio:db:seed:dump"].invoke
       Rake::Task["cargas:db:seed:dump"].invoke
     end
    end
    #task :rollback do
     # Rake::Task["db:rollback"].invoke
    #end
    task :version do
      Rake::Task["electrico:db:version"].invoke
      Rake::Task["gestion:db:version"].invoke
      Rake::Task["comercio:db:version"].invoke
      Rake::Task["cargas:db:version"].invoke
    end
    namespace :schema do
      task :load do
        Rake::Task["electrico:db:schema:load"].invoke
        Rake::Task["gestion:db:schema:load"].invoke
        Rake::Task["comercio:db:schema:load"].invoke
        Rake::Task["cargas:db:schema:load"].invoke

      end
      task :dump do
        Rake::Task["electrico:db:schema:dump"].invoke
        Rake::Task["gestion:db:schema:dump"].invoke
        Rake::Task["comercio:db:schema:dump"].invoke
        Rake::Task["cargas:db:schema:dump"].invoke
      end
    end
    namespace :test do
      task :prepare do
	Rake::Task['electrico:db:test:prepare'].invoke
	Rake::Task['comercio:db:test:prepare'].invoke
	Rake::Task['gestion:db:test:prepare'].invoke
	Rake::Task['cargas:db:test:prepare'].invoke
      end
    end
  end
end

=begin
  Rails.env = ENV['RAILS_ENV'] = 'test'
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  result = capture_stdout { Rake::Task['db:schema:load'].invoke }
  File.open(File.join(ENV['CC_BUILD_ARTIFACTS'] || 'log', 'schema-load.log'), 'w') { |f| f.write(result) }
  Rake::Task['db:seed:load'].invoke
  ActiveRecord::Base.establish_connection
  Rake::Task['db:migrate'].invoke
end
=end
