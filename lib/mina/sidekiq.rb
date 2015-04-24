###########################################################################
# Unicorn Tasks
###########################################################################
require 'mina/scp'

namespace :sidekiq do
  desc "Upload and update (link) all Sidekiq config files"
  task :update => [:upload, :link]

  desc "Relocate sidekiq script file"
  task :link do
    invoke :sudo
    queue 'echo "-----> Relocate sidekiq script file"'
    queue echo_cmd %{sudo cp "#{config_path}/sidekiq.sh" "#{sidekiq_script!}" && sudo chown #{sidekiq_user}:#{sidekiq_group} #{sidekiq_script} && sudo chmod ugo+x #{sidekiq_script}}
    queue echo_cmd %{sudo cp "#{config_path}/sidekiq.conf" "#{sidekiq_monit_path}"}
    queue check_ownership sidekiq_user, sidekiq_group, sidekiq_script
  end

  desc "Parses all Sidekiq config files and uploads them to server"
  task :upload => [:'upload:config', :'upload:script', :'upload:monit']

  namespace :upload do
    desc "Uploads sidekiq config to server"
    task :config do
      scp_upload "#{config_files_path}/sidekiq.yml", "#{config_path}/sidekiq.yml", verbose: true
    end

    desc "Parses Sidekiq control script file and uploads it to server"
    task :script do
      upload_template 'Sidekiq control script', 'sidekiq.sh', "#{config_path}/sidekiq.sh"
    end

    desc "Parses Sidekiq monit file and uploads it to server"
    task :monit do
      upload_template 'Sidekiq monit', 'sidekiq.conf', "#{config_path}/sidekiq.conf"
    end
  end

  %w(stop start restart).each do |action|
    desc "#{action.capitalize} Sidekiq"
    task action.to_sym => :environment do
      queue %{echo "-----> #{action.capitalize} Sidekiq"}
      queue echo_cmd "sudo monit #{action} sidekiq-#{app}"
    end
  end

end
