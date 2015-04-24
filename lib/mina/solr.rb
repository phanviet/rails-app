###########################################################################
# Solr Tasks
###########################################################################
require 'mina/scp'

namespace :solr do
  desc "Create configuration and other files"
  task :setup do
    queue 'echo "-----> Setup Solr"'
    queue echo_cmd %[sudo chown -R #{user}:#{group} "#{solr_installed_path}"]
    queue echo_cmd %[sudo chown -R #{user}:#{group} "#{solr_data_dir}"]
    queue echo_cmd %[touch "#{solr_pid_file}"]
    queue echo_cmd %[touch "#{solr_log_file}"]
  end

  desc "Upload solr config file"
  task :update => [:upload, :link]
  task :upload => [:'upload:config', :'upload:auth', :'upload:collection']

  desc "Parses solr config file and uploads it to server"
  namespace :upload do
    desc "Parses Sunspot config file and uploads it to server"
    task :config do
      upload_template 'sunspot config', 'sunspot.yml', "#{config_path}/sunspot.yml"
    end

    desc "Uploads jetty authentication configs to server"
    task :auth do
      scp_upload "#{config_files_path}/solr/config/realm.properties", "#{config_path}/realm.properties", verbose: true
      scp_upload "#{config_files_path}/solr/config/web.xml", "#{solr_web_app_path}/WEB-INF/web.xml", verbose: true
      scp_upload "#{config_files_path}/solr/config/jetty.xml", "#{solr_web_config_path}/jetty.xml", verbose: true
    end

    desc "Uploads collection to server"
    task :collection do
      scp_upload "#{config_files_path}/solr/collection/.", "#{solr_data_dir}", recursively: true, verbose: true
    end
  end

  desc "Symlink config file"
  task :link do
    queue %{echo "-----> Symlink Solr config file"}

    queue echo_cmd %{sudo ln -fs "#{config_path}/realm.properties" "#{solr_auth}"}
    queue check_symlink solr_auth
  end

  task :reindex do
    queue! %[#{rake} sunspot:reindex]
  end

  %w(stop start restart).each do |action|
    desc "#{action.capitalize} Solr"
    task action.to_sym do
      queue %{echo "-----> #{action.capitalize} Solr"}
      queue echo_cmd "sudo service solr #{action}"
    end
  end
end
