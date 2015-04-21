###########################################################################
# Monit Tasks
###########################################################################

namespace :monit do
  desc "Reload monit"
  task :reload do
    queue 'echo "-----> Reload monit"'
    queue echo_cmd %{sudo monit reload}
  end
end
