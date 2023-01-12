# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :install_apt_dependencies do
  sh 'xargs -a package-list.txt apt-get -y install' # install apt packages and their dependencies
  # sh 'sudo dpkg --set-selections < package-list.txt'
  # sh 'sudo apt-get -y update'
  # sh 'sudo apt-get dselect-upgrade'
end

task :install_ruby do
  sh 'sudo apt install rbenv'
  sh 'rbenv init'
  sh 'echo "eval \'$(~/.rbenv/bin/rbenv init - bash)\'" >> ~/.bashrc'

  sh 'rbenv install 3.2.0'
  sh 'rbenv global 3.2.0'
  sh 'rbenv local 3.2.0'
end

task :install_gems do
  sh 'bundle update'
  sh 'bundle install'
end

task :install_yarn do
  sh 'sudo apt update' # might not be necessary
  sh 'sudo apt install nodejs'
  sh 'node -v'

  sh 'sudo apt remove cmdtest'
  sh 'sudo apt install yarn'
  sh 'yarn'
end

task :model_init do
  sh 'rake db:migrate'
  sh 'rake db:seed'
end

task :run_tests do
  sh 'cucumber -q --tags "not @skip"'
  sh 'rspec'
end
