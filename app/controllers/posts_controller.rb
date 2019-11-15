# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :signed_in_user, only: %i[new create]
  def new
    @post = Post.new
  end

  def create; end

  def index; end

  private

  def signed_in_user
    return if logged_in?

    flash[:danger] = 'Please log in.'
    redirect_to signin_url
  end
end
