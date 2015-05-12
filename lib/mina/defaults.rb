# All default paths setting
namespace :defaults do
  task :configs do
    # General config
    set_default :app_path             , "#{deploy_to}/#{current_path}"
    set_default :config_path          , "#{deploy_to}/#{shared_path}/config"
    set_default :config_templates_path, "lib/mina/templates"
    set_default :config_files_path    , "lib/mina/files"
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
    set_default :unicorn_log          , "#{logs_path}/unicorn.log"
    set_default :unicorn_error_log    , "#{logs_path}/unicorn.error.log"
    set_default :unicorn_config       , "#{config_path}/unicorn.rb"
    set_default :unicorn_script       , "#{services_path!}/unicorn-#{app!}"
    set_default :unicorn_workers      , 4
    set_default :unicorn_bin          , 'bundle exec unicorn' # you may prefer this over the line below
    # set_default :unicorn_bin        , "#{deploy_to}/#{current_path}/bin/unicorn_rails"
    set_default :unicorn_user         , "#{user}"
    set_default :unicorn_group        , "#{group}"
    # monit configs
    set_default :monit_path           , "/etc/monit/conf.d"
    set_default :unicorn_monit_path   , "#{monit_path}/unicorn-#{app}.conf"
    set_default :sidekiq_monit_path   , "#{monit_path}/sidekiq-#{app}.conf"
    set_default :puma_monit_path      , "#{monit_path}/puma-#{app}.conf"
    # solr config
    set_default :solr_installed_path  , '/opt/solr-4.6.1'
    set_default :solr_web_app_path    , "#{solr_installed_path}/example/solr-webapp/webapp"
    set_default :solr_web_config_path , "#{solr_installed_path}/example/etc/"
    set_default :solr_data_dir        , "#{deploy_to}/#{shared_path}/solr"
    set_default :solr_pid_file        , "#{pids_path}/solr.pid"
    set_default :solr_log_file        , "#{logs_path}/solr.log"
    set_default :solr_auth            , "#{solr_web_config_path}/realm.properties"
    # sidekiq config
    set_default :sidekiq_config       , "#{config_path}/sidekiq.yml"
    set_default :sidekiq_log          , "#{logs_path}/sidekiq.log"
    set_default :sidekiq_pid          , "#{pids_path}/sidekiq.pid"
    set_default :sidekiq_script       , "#{services_path!}/sidekiq-#{app!}"
    set_default :sidekiq_user         , "#{user}"
    set_default :sidekiq_group        , "#{group}"
    # puma config
    set_default :puma_socket          , "#{sockets_path}/puma.sock"
    set_default :puma_pid             , "#{pids_path}/puma.pid"
    set_default :puma_log             , "#{logs_path}/puma.log"
    set_default :puma_state           , "#{logs_path}/puma.state"
    set_default :puma_error_log       , "#{logs_path}/puma.error.log"
    set_default :puma_workers         , 2
    set_default :puma_threads         , 5
    set_default :puma_user            , "#{user}"
    set_default :puma_group           , "#{group}"
    set_default :puma_script          , "#{services_path!}/puma-#{app!}"
    set_default :puma_config          , "#{config_path}/puma.rb"
  end
end
