class UsersController < ApplicationController
  def welcome
    redirect_to root_path, notice: 'You are already signed in.' if user_signed_in?
  end
end
