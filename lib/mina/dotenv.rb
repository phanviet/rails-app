###########################################################################
# .env Tasks
###########################################################################

namespace :dotenv do
  desc "Upload .env config file"
  task :update => [:upload]

  desc "Parses .env config file and uploads it to server"
  task :upload => [:'upload:config']

  namespace :upload do
    desc "Parses Rails ENV variables config file and uploads it to server"
    task :config do
      upload_template 'Rails ENV variables config', 'env', "#{deploy_to}/shared/.env"
    end
  end

  desc "Parses .env config file and shows them in output"
  task :parse => [:'parse:config']

  namespace :parse do
    desc "Parses .env config file and shows it in output"
    task :config do
      puts "#"*80
      puts "# .env"
      puts "#"*80
      puts erb("#{config_templates_path}/env.erb")
    end
  end
end
