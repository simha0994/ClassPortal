class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
  	user = User.find_by(name: params[:name])
  	#if user.password.nil?
  	#	redirect_to login_url, alert:"Password Nil"
  	#else
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to admin_url, alert:"Already Logged in"
  	else
  		redirect_to login_url, alert:"Invalid username or password"
  	end
  #end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to login_url, alert:"Logged out Successfully"
  end
end
