class UserController < ApplicationController

  def login_view

  end

  def create_login_session
      redirect_to :login
  end

end
