class PostsController < ApplicationController

  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
    if params[:author_id]
      @post = Author.find(params[:author_id]).posts.find(params[:id])
    else
      @post = Post.find(params[:id])
    end
  end

 def new
   if params[:author_id] && !Author.exists?(params[:author_id])
     redirect_to authors_path, alert: "Author not found."
   else
     @post = Post.new(author_id: params[:author_id])
   end
 end
 # Why aren't we doing a find_by and getting the author instance? Because we don't need a whole author instance for Post.new; we just need the author_id. And we don't need to check against the posts of the author because we're just creating a new one. 

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
  if params[:author_id]
    author = Author.find_by(id: params[:author_id])
    if author.nil?
      redirect_to authors_path, alert: "Author not found."
    else
      @post = author.posts.find_by(id: params[:id])
      redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
    end
    # If we do find the author, we next want to find the post by params[:id], but, instead of directly looking for Post.find(), we need to filter the query through our author.posts collection to make sure we find it in that author's posts. It may be a valid post id, but it might not belong to that author, which makes this an invalid request.
  else
    @post = Post.find(params[:id])
  end
end

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
