#!/bin/ruby
# encoding: utf-8

require 'spec_helper'

describe MicropostsController do
  render_views

  describe "contrôle d'accès" do

    it "devrait refuser l'accès pour  'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "devrait refuser l'accès pour  'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
    end

    describe "échec" do

      before(:each) do
        @attr = { :content => "" }
      end

      it "ne devrait pas créer de micro-message" do
        lambda do
          post :create, :micropost => @attr
        end.should_not change(Micropost, :count)
      end

      it "devrait retourner la page d'accueil" do
        post :create, :micropost => @attr
        response.should render_template('pages/home')
      end
    end

    describe "succès" do

      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end

      it "devrait créer un micro-message" do
        lambda do
          post :create, :micropost => @attr
        end.should change(Micropost, :count).by(1)
      end

      it "devrait rediriger vers la page d'accueil" do
        post :create, :micropost => @attr
        response.should redirect_to(root_path)
      end

      it "devrait avoir un message flash" do
        post :create, :micropost => @attr
        flash[:success].should =~ /Micropost créé/i
      end
    end
  end
  describe "DELETE 'destroy'" do

    describe "pour un utilisateur non auteur du message" do

      before(:each) do
        @user = FactoryGirl.create(:user)
        wrong_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
        test_sign_in(wrong_user)
        @micropost = FactoryGirl.create(:micropost, :user => @user)
      end

      it "devrait refuser la suppression du message" do
        delete :destroy, :id => @micropost
        response.should redirect_to(root_path)
      end
    end

    describe "pour l'auteur du message" do

      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        @micropost = FactoryGirl.create(:micropost, :user => @user)
      end

      it "devrait détruire le micro-message" do
        lambda do 
          delete :destroy, :id => @micropost
        end.should change(Micropost, :count).by(-1)
      end
    end
  end
end