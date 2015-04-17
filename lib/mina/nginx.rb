###########################################################################
# nginx Tasks
###########################################################################

namespace :nginx do
  desc "Create configuration and other files"
  task :setup do
    queue echo_cmd "mkdir -p #{nginx_log_path}"
    queue echo_cmd "sudo chown #{nginx_user}:#{nginx_group} #{nginx_log_path}"
    queue echo_cmd "sudo chmod -R 755 #{nginx_log_path}"
  end

  desc "Upload and update (link) all nginx config file"
  task :update => [:upload, :link]

  desc "Symlink config file"
  task :link do
    queue %{echo "-----> Remove default site configuration"}

    # TODO: Change the nginx config path
    queue echo_cmd %{sudo rm -f /etc/nginx/sites-available/default}
    queue echo_cmd %{sudo rm -f /etc/nginx/sites-enabled/default}

    queue %{echo "-----> Symlink nginx config file"}

    queue echo_cmd %{sudo ln -fs "#{config_path}/nginx.site.conf" "#{nginx_site_available}"}
    queue check_symlink nginx_site_available

    queue echo_cmd %{sudo ln -fs "#{config_path}/nginx.site.conf" "#{nginx_site_enabled}"}
    queue check_symlink nginx_site_enabled
  end

  desc "Parses nginx config file and uploads it to server"
  task :upload do
    upload_template 'nginx config', 'nginx.site.conf', "#{config_path}/nginx.site.conf"
  end

  desc "Parses config file and outputs it to STDOUT (local task)"
  task :parse do
    puts "#"*80
    puts "# nginx.site.conf"
    puts "#"*80
    puts erb("#{config_templates_path}/nginx.site.conf.erb")
  end

  %w(stop start restart reload status).each do |action|
    desc "#{action.capitalize} Nginx"
    task action.to_sym do
      queue %{echo "-----> #{action.capitalize} Nginx"}
      queue echo_cmd "sudo service nginx #{action}"
    end
  end
end
