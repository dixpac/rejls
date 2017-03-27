class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @posts = Post.all
    response.write "<h1>Well, hello! Your posts are</h1>"
    response.write "<ul>"
    @posts.each do |post|
      response.write "<li>#{post.title}</h1>"
    end
    response.write "</ul>"
  end

  def show
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
