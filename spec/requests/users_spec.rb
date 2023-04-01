require 'rails_helper'

RSpec.describe "Users", type: :request do
  login_user

  describe "GET /index" do
    login_admin

    it "returns http success" do
      get "/account/users"
      expect(response).to have_http_status(:success)
    end

    it "renders :index" do
      get "/account/users"
      expect(response).to render_template :index
    end

    it "lists users" do
      get "/account/users"
      expect(assigns(:users).length).to equal(1)
    end
  end

  describe "GET /me" do
    it "returns http success" do
      get "/user/me"
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update_me" do
    user = FactoryBot.create(:user)
    it "returns http success" do
      patch  "/user/update_me", params: {id: user.id, user: {name: 'John'}}
      expect(response).to redirect_to my_settings_path
    end

    it "renders :me of failure" do
      patch  "/user/update_me", params: {
        id: user.id,
        user: {name: 'John', email: nil}
      }
      expect(response).to render_template :me
    end
  end

  describe "GET #password" do
    it "returns http success" do
      get '/user/password'
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update_password" do
    user = FactoryBot.create(:user)
    it "returns http success" do
      patch '/user/update_password', params: {
        id: user.id,
        user: {password: 'd2g4j6mlp', password_confirmation: 'd2g4j6mlp'}
      }
      expect(response).to redirect_to my_password_path
    end

    it "renders :password of failure" do
      patch '/user/update_password', params: {id: user.id, user: {
        password: '123',
        password_confirmation: '123'
      }}
      expect(response).to render_template :password
    end
  end

  describe "GET /new" do
    login_admin
    
    it "returns http success" do
      get "/account/users/new"
      expect(response).to have_http_status(:success)
    end

    it "renders new template" do
      get "/account/users/new"
      expect(response).to render_template :new
    end

    it "fails on unauthenticated user" do
      user = User.create!(
        name: "John",
        email: "specuseruser@test.com",
        password: 'spec123')
      user.add_role :user
      sign_in user
      get "/account/users/new"
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "POST #create" do
    login_admin

    it "creates an user" do
      post "/account/users", params: {
        user: FactoryBot.attributes_for(:user, {role: 'user'})
      }
      expect(response).to redirect_to account_users_path
    end

    it "renders :new on failure" do
      post "/account/users",  params: {
        user: FactoryBot.attributes_for(:user,{email: nil, role: 'user'})
      }
      expect(response).to render_template :new
    end

    it "fails on non-unique email" do
      user = FactoryBot.create(:user)
      post "/account/users",  params: {
        user: FactoryBot.attributes_for(:user,{
          email: user.email,
          role: 'user'
          }
        )}
      expect(response).to render_template :new
    end
  end

  describe "GET /edit" do
    login_admin

    user = FactoryBot.create(:user)
    it "returns http success" do
      get "/account/users/#{user.id}/edit"
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
       get "/account/users/#{user.id}/edit"
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
    login_admin

    user = FactoryBot.create(:user)
    it "returns http success" do
      put "/account/users/#{user.id}",  params: {id: user.id, user: {name: "Yay"}}
      expect(response).to redirect_to account_users_path
    end

    it "renders :edit on failure" do
      put "/account/users/#{user.id}",  params: {
        id: user.id,
        user: FactoryBot.attributes_for(:user,{email: nil, role: 'user'})
      }
      expect(response).to render_template :edit
    end
  end

  describe "DELETE #destroy" do
    login_admin

    user = FactoryBot.create(:user)
    it "returns http success" do
      delete "/account/users/#{user.id}",  params: {id: user.id}
      expect(response).to redirect_to account_users_path
    end
  end
end