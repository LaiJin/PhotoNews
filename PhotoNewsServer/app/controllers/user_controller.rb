class UserController < ApplicationController

  def login_view

  end

  def create_login_session
    user = User.find_by_name(params[:user][:name])

    if user && user.authenticate(params[:user][:password])
      cookies.permanent[:token] = user.token
      redirect_to :image_show_view
      return
    end
    flash[:login_error] = '用户名或密码错误'
    redirect_to :login
  end

  def logout
    cookies.delete(:token)
    redirect_to :login
  end

end
