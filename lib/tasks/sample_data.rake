#!/bin/ruby
# encoding: utf-8

namespace :db do
  desc "Peupler la base de données"
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end
def make_users
  administrateur = User.create!(:nom => "Example User",
                       :email => "example@railstutorial.org",
                       :password => "foobar",
                       :password_confirmation => "foobar")
  administrateur.toggle!(:admin)
  User.create!(:nom => "Utilisateur exemple",
               :email => "example2@railstutorial.org",
               :password => "foobar",
               :password_confirmation => "foobar")
  99.times do |n|
    nom  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "motdepasse"
    User.create!(:nom => nom,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end
def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end
end
def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each do |followed|
    user.follow!(followed)
  end
  followers.each do |follower|
    follower.follow!(user)
  end
end