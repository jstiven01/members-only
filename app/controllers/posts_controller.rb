# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :signed_in_user, only: %i[new create]
  def new
    @post = Post.new
  end

  def create
    params_permited = post_params
    @post = Post.new(user_id: session[:user_id], title: params_permited[:title], content: params_permited[:content])
    if @post.save
      redirect_to posts_path
    else
      flash.now[:danger] = 'Error creating the post'
      render 'new'
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  private

  def signed_in_user
    return if logged_in?

    flash[:danger] = 'Please log in.'
    redirect_to signin_url
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
