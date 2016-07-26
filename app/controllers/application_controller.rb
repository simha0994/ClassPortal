class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize
  include SessionsHelper

  def is_instructor_logged_in
  	unless User.find_by(id: session[:user_id])
  		unless current_user.usertype == "Instructor"
  			redirect_to '/', notice:"Only instructors can view this page"
  		end
  	end
  end

  def is_admin_logged_in
  	if current_user 
  		if current_user.usertype != "Admin"
  			redirect_to '/', notice:"Only Admin can view this page"
  		end
  	end
  end
  protected
  def authorize
  	unless User.find_by(id: session[:user_id])
  		redirect_to login_url, notice:"Unauthorized access not allowed"
  	end
  end


end
