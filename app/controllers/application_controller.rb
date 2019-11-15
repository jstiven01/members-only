# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def sign_in(user)
    session[:id] = user.id
    cookies.permanent.signed[:user_id] = user.id
    user.create_remember_token
    cookies.permanent[:remember_token] = user.remember_token
  end
end
