#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    #definition de la base du titre
    @base_title = "Simple App du Tutoriel Ruby on Rails"
  end

  #tests de la page "home"
  describe "GET 'home'" do
    #test d'existence
    it "devrait réussir" do
      get 'home'
      response.should be_success
    end
    #test de titre
    it "devrait avoir le bon titre" do
      get 'home'
      response.should have_selector("title", :content => @base_title + " | Accueil")
    end
  end

  #tests de la page "contact"
  describe "GET 'contact'" do
    #test d'existence
    it "devrait réussir" do
      get 'contact'
      response.should be_success
    end
    #test de titre
    it "devrait avoir le bon titre" do
      get 'contact'
      response.should have_selector("title", :content => @base_title + " | Contact")
    end
  end

  #tests de la page "about"
  describe "GET 'about'" do
    #test d'existence
    it "devrait réussir" do
      get 'about'
      response.should be_success
    end
    #test de titre
    it "devrait avoir le bon titre" do
      get 'about'
      response.should have_selector("title", :content => @base_title + " | À Propos")
    end
  end

  #tests de la page "help"
  describe "GET 'help'" do
    #test d'existence
    it "devrait réussir" do
      get 'help'
      response.should be_success
    end
    #test de titre
    it "devrait avoir le bon titre" do
      get 'help'
      response.should have_selector("title", :content => @base_title + " | Aide")
    end
  end

end
