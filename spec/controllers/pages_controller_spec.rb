#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    #definition de la base du titre
    @base_title = "Simple App du Tutoriel Ruby on Rails"
  end

  describe "GET 'home'" do

    describe "quand pas identifié" do

      before(:each) do
        get :home
      end

      it "devrait réussir" do
        response.should be_success
      end

      it "devrait avoir le bon titre" do
        response.should have_selector("title",
                                      :content => "#{@base_titre} | Accueil")
      end
    end

    describe "quand identifié" do

      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        other_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
        other_user.follow!(@user)
      end

      it "devrait avoir le bon compte d'auteurs et de lecteurs" do
        get :home
        response.should have_selector("a", :href => following_user_path(@user),
                                           :content => "0 auteur suivi")
        response.should have_selector("span", :id => "followers",
                                           :content => "1 lecteur")
      end
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
