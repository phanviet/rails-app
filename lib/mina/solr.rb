###########################################################################
# Solr Tasks
###########################################################################
require 'mina/scp'

namespace :solr do
  desc "Create configuration and other files"
  task :setup do
    queue 'echo "-----> Setup Solr"'
    queue echo_cmd %[sudo chown -R #{user}:#{group} "#{solr_data_dir}"]
    queue echo_cmd %[touch "#{solr_pid_file}"]
    queue echo_cmd %[touch "#{solr_log_file}"]
  end

  desc "Upload solr config file"
  task :update => [:upload, :link]

  desc "Parses solr config file and uploads it to server"
  task :upload do
    upload_template 'realm properties', 'solr/realm.properties', "#{config_path}/realm.properties"
    upload_template 'sunspot config', 'solr/sunspot.yml', "#{config_path}/sunspot.yml"
    upload_template 'auth for admin page', 'solr/web.xml', "#{solr_web_app_path}/WEB-INF/web.xml"
    upload_template 'realm config', 'solr/jetty.xml', "#{solr_web_config_path}/jetty.xml"
    scp_upload "#{config_files_path}/solr/.", "#{solr_data_dir}", recursively: true, verbose: true
  end

  desc "Symlink config file"
  task :link do
    queue %{echo "-----> Symlink sunspot config file"}
    queue echo_cmd %{sudo rm -f "#{config_path}/sunspot.yml"}
    queue echo_cmd %{sudo ln -fs "#{config_path}/sunspot.yml" "#{sunspot_config}"}
    queue check_symlink sunspot_config
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
