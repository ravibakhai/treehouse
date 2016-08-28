class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @properties = @user.properties
  end
end
