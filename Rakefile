# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

<<<<<<< HEAD
task :model_init do
  sh 'rake db:migrate'
  sh 'rake db:seed'
end

task :run_tests do
  sh 'cucumber -q --tags "not @skip"'
  sh 'rspec'
end

task :cucumber, [:param] do |_t, args|
  sh "cucumber #{args[:param]}"
end
