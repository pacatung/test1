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
		respond_to do |format|
      if @post.save
        if params[:images]
          #===== post images[]
          params[:images].each { |image|
            @post.imageables.create(image: image)
          }
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      end
    end
	end
	def show
		@imageables = @post.imageables
		puts @imageables.inspect
	end
	def edit
	end
	def update
	  @post.update(post_params)

	  redirect_to post_url(@post)
	end
	def destroy
		@post.delete
		redirect_to posts_url
	end

private
	def find_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit( :title, :content, imageables_attributes:[:post_id, :image], locations_attributes:[:location,:_destroy,:id])
  end
 
end
