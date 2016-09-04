class PostsController < ApplicationController
	before_action :find_post, :only => [ :show, :edit, :update, :destroy]
	before_action :set_s3_direct_post, :only => [ :new, :create, :edit, :update]
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
	def set_s3_direct_post
		puts S3_BUCKET.inspect
    @s3_direct_post =S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end
end
