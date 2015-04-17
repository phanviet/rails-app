# All default paths setting
namespace :defaults do
  task :configs do
    # General config
    set_default :app_path             , "#{deploy_to}/#{current_path}"
    set_default :config_path          , "#{deploy_to}/#{shared_path}/config"
    set_default :config_templates_path, "lib/mina/templates"
    set_default :pids_path            , "#{deploy_to}/#{shared_path}/pids"
    set_default :sockets_path         , "#{deploy_to}/#{shared_path}/sockets"
    set_default :logs_path            , "#{deploy_to}/#{shared_path}/log"
    set_default :rvm_path             , "/usr/local/rvm/scripts/rvm"
    set_default :services_path        , '/etc/init.d'
    # Nginx configs
    set_default :nginx_path           , '/etc/nginx'
    set_default :nginx_site_available , "#{nginx_path}/sites-available/#{app!}.conf"
    set_default :nginx_site_enabled   , "#{nginx_path}/sites-enabled/#{app!}.conf"
    set_default :nginx_log_path       , "/var/log/nginx"
    set_default :nginx_user           , "www-data"
    set_default :nginx_group          , "www-data"
    set_default :nginx_server_name    , "#{domain}"
    # Unicorn configs
    set_default :unicorn_socket       , "#{sockets_path}/unicorn.sock"
    set_default :unicorn_pid          , "#{pids_path}/unicorn.pid"
    set_default :unicorn_config       , "#{config_path}/unicorn.rb"
    set_default :unicorn_script       , "#{services_path!}/unicorn-#{app!}"
    set_default :unicorn_workers      , 4
    set_default :unicorn_bin          , 'bundle exec unicorn' # you may prefer this over the line below
    # set_default :unicorn_bin        , "#{deploy_to}/#{current_path}/bin/unicorn_rails"
    set_default :unicorn_user         , "#{user}"
    set_default :unicorn_group        , "#{group}"
  end
end
