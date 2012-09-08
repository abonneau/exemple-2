#!/bin/ruby
# encoding: utf-8

require 'factory_girl_rails'

FactoryGirl.define do

	sequence :email do |n|
		"person-#{n}@example.com"
	end

	factory :user do |user|
		user.nom					"Aurélien Bonneau"
		user.email					FactoryGirl.generate :email
		user.password 				"foobar"
		user.password_confirmation	"foobar"
	end

	factory :micropost do |micropost|
		micropost.content "foo bar"
		micropost.association :user
	end
	
end