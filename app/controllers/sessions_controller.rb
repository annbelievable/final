
require 'securerandom'

class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to user_path(current_user)
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: 'Logged in!'
    else
      flash.now.alert = 'Email or password is invalid'
      render :new
    end
  end

  def create_from_omniauth
    auth_hash = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.new(provider: auth_hash['provider'], uid: auth_hash["uid"])
    if authentication.user
      user = authentication.user
      redirect_to user_path(user), notice: "Logged in through #{auth_hash['provider']}."
    else
      temp_pass = SecureRandom.base64(4)
      user = User.new(username: auth_hash["info"]["name"], email: auth_hash["info"]["email"], password: temp_pass, password_confirmation: temp_pass)
      user.authentications.build(provider: auth_hash['provider'], uid: auth_hash["uid"])
      user.save
      redirect_to edit_user_path(user), notice: "Signed in successfully through #{auth_hash['provider']}!"
    end
    session[:user_id] = user.id
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
