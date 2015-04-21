
namespace :bower do
  set_default :bower_bin, "#{rake} bower:"
  set_default :bower_options, "RAILS_ENV=#{rails_env}"
  set_default :bower_shared, "#{deploy_to}/#{shared_path}/bower"
  set_default :bower_path, './vendor/assets/bower_components'

  # Installs assets.
  desc "Install dependencies using Bower."
  task :install do
    queue %{
      echo "-----> Installing dependencies using Bower"
      #{echo_cmd %[mkdir -p "#{bower_shared}"]}
      #{echo_cmd %[mkdir -p "#{File.dirname bower_path}"]}
      #{echo_cmd %[ln -s "#{bower_shared}" "#{bower_path}"]}
      #{echo_cmd %[#{bower_bin}install:deployment #{bower_options}]}
    }
  end

  desc "Remove old packages and installing dependencies using Bower"
  task :'install:force' do
    queue %{
      echo "-----> Remove old packages and installing dependencies using Bower"
      #{echo_cmd %[rm -rf #{bower_shared}/bower_components]}
      #{echo_cmd %[#{bower_bin}install:deployment #{bower_options}]}
    }
  end
end
