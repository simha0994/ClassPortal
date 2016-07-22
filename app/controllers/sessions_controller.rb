class SessionsController < ApplicationController
	skip_before_action :authorize
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	#if session[:user_id].nil?
  	#	redirect_to login_url, alert:"Password Nil"
  	#else
  	if user and user.authenticate(params[:password])
      #puts "#{user.usertype}"
      puts session[:user_id]
  		session[:user_id] = user.id
  		redirect_to user, alert:"Already Logged in"
  	else
  		redirect_to login_url, alert:"Invalid username or password"
  	end
    #else
      #redirect_to admin_url, alert:"Already Logged in"
    #end
  end
  
  def destroy
  	session[:user_id] = nil
  	redirect_to login_url, alert:"Logged out Successfully"
  end
end
