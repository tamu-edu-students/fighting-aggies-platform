# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Video.create("/home/ubuntu/environment/fighting-aggies-platform/storage/supplementary_video.mp4")

initial_users = [
    {:name => 'Tuong Tran', :role => 'admin', :email => 't2tran@tamu.edu'},
    {:name => 'Andrew Imwalle', :role => 'admin', :email => 'andrew.imwalle@tamu.edu'},
    {:name => 'Nick McDonough', :role => 'admin', :email => 'nimcd@tamu.edu'},
    {:name => 'Eli Tracy', :role => 'admin', :email => 'elitracy@tamu.edu'}
]

initial_users.each do |user|
    Users.create!(user)
  end