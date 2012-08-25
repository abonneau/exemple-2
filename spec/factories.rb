#!/bin/ruby
# encoding: utf-8

require 'factory_girl_rails'

FactoryGirl.define do
	factory :user do |user|
		user.nom					"Aurélien Bonneau"
		user.email					"aurelienbonneau@free.fr"
		user.password 				"foobar"
		user.password_confirmation	"foobar"
	end
end