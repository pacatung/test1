class PostsController < ApplicationController
	  before_action :find_post, :only => [ :show, :edit, :update, :destroy]
	def index
		@posts = Post.order("id DESC").limit(15)		
	end

	def new
		@post = Post.new
	end

	def create
    @post = Post.new(post_params)
		@post.save

		redirect_to posts_url
	end
	def show
	end
	def edit
	end
	def update
	  @post = Post.find(params[:id])
	  @post.update(post_params)

	  redirect_to post_url(@post)
	end
	def destroy
		@post.delete
		redirect_to posts_url
	end

protected
	def find_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit( :title, :content, photos_attributes: [:post_id, :photo_location, :pic],countries_attributes:[:country,:_destroy,:id],
      locations_attributes:[:location,:_destroy,:id])
  end
end
