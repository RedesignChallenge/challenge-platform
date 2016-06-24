class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    redirect_to root_path if @user.nil?
  end
end
