###########################################################################
# Puma Tasks
###########################################################################

namespace :puma do
  desc "Upload and update (link) all Puma config files"
  task :update => [:upload, :link]

  desc "Relocate puma script file"
  task :link do
    invoke :sudo
    queue 'echo "-----> Relocate puma script file"'
    queue echo_cmd %{sudo cp "#{config_path}/puma.sh" "#{puma_script!}" && sudo chown #{puma_user}:#{puma_group} #{puma_script} && sudo chmod ugo+x #{puma_script}}
    queue echo_cmd %{sudo cp "#{config_path}/puma.conf" "#{puma_monit_path}"}
    queue check_ownership puma_user, puma_group, puma_script
  end

  desc "Parses all Puma config files and uploads them to server"
  task :upload => [:'upload:config', :'upload:script', :'upload:monit']

  namespace :upload do
    desc "Parses Puma config file and uploads it to server"
    task :config do
      upload_template 'Puma config', 'puma.rb', "#{config_path}/puma.rb"
    end

    desc "Parses Puma control script file and uploads it to server"
    task :script do
      upload_template 'Puma control script', 'puma.sh', "#{config_path}/puma.sh"
    end

    desc "Parses Puma monit file and uploads it to server"
    task :monit do
      upload_template 'Puma monit', 'puma.conf', "#{config_path}/puma.conf"
    end
  end

  desc "Parses all Puma config files and shows them in output"
  task :parse => [:'parse:config', :'parse:script']

  namespace :parse do
    desc "Parses Puma config file and shows it in output"
    task :config do
      puts "#"*80
      puts "# puma.rb"
      puts "#"*80
      puts erb("#{config_templates_path}/puma.rb.erb")
    end

    desc "Parses Puma control script file and shows it in output"
    task :script do
      puts "#"*80
      puts "# puma.sh"
      puts "#"*80
      puts erb("#{config_templates_path}/puma.sh.erb")
    end
  end

  %w(stop start restart).each do |action|
    desc "#{action.capitalize} Puma"
    task action.to_sym => :environment do
      queue %{echo "-----> #{action.capitalize} Puma"}
      queue echo_cmd "sudo monit #{action} puma-#{app}"
    end
  end
end
