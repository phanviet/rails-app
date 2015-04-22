###########################################################################
# Solr Tasks
###########################################################################

namespace :solr do
  desc "Create configuration and other files"
  task :setup do
    queue 'echo "-----> Setup Solr"'
    queue echo_cmd %[sudo chown -R #{user} "#{solr_data_dir}"]
    queue echo_cmd %[touch "#{solr_pid_file}"]
    queue echo_cmd %[touch "#{solr_log_file}"]
  end

  desc "Upload solr config file"
  task :update => [:upload]

  desc "Parses solr config file and uploads it to server"
  task :upload do
    scp_upload "#{config_files_path}/solr/.", "#{solr_data_dir}"
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
