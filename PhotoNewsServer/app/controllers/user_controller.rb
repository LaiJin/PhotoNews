class UserController < ApplicationController

  def login_view

  end

  def create_login_session
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      cookies.permanent[:token] = user.token
      redirect_to :image_show_view
      return
    end
    flash[:login_error] = '用户名或密码错误'
    redirect_to :login
  end

end
