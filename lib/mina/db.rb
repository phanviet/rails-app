###########################################################################
# Postgresql Database Tasks
###########################################################################

namespace :db do
  desc "Upload database.yml config file"
  task :update => [:upload]

  desc "Parses database.yml config file and uploads it to server"
  task :upload => [:'upload:config']

  namespace :upload do
    desc "Parses database config file and uploads it to server"
    task :config do
      upload_template 'Database config', 'database.yml', "#{config_path!}/database.yml"
    end
  end

  desc "Parses database.yml config file and shows them in output"
  task :parse => [:'parse:config']

  namespace :parse do
    desc "Parses database.yml config file and shows it in output"
    task :config do
      puts "#"*80
      puts "# database.yml"
      puts "#"*80
      puts erb("#{config_templates_path!}/database.yml.erb")
    end
  end
end
