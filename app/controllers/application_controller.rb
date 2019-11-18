# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def sign_in(user)
    session[:user_id] = user.id
    cookies.permanent.signed[:user_id] = user.id
    user.create_remember_token
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(:remember, cookies[:remember_token])
        sign_in user
        @current_user = user
      end
    end
  end

  helper_method :current_user

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  helper_method :current_user?

  # Returns true if the user is logged in,il false otherwise.
  def logged_in?
    !current_user.nil?
  end

  helper_method :logged_in?

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def sign_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
