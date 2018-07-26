class BlogsController < ApplicationController
  def index
    @users=Admin.all
    @blogs=Blog.all
    @comments=Comment.all
    @lists=List.all.order(:cached_votes_up => :desc)
    @popular=List.order(:cached_weighted_average => :desc)
  end

  def show
    @blog = Blog.find(params[:id])
    @blogs = Blog.find(params[:id])
    @comment=Comment.new
  end

def edit
    admin=current_admin
    @blog = Blog.find(params[:id])
  if current_admin
    if @blog.admin_id != admin.id
      redirect_to "/"
    end
  else
  redirect_to "/"
  end
end

def update
  @blog = Blog.find(params[:id])
  if(@blog.update(blog_params))
    redirect_to "/"
  else
    render edit_blog_path
  end
end

def destroy
  @blog = Blog.find(params[:id])
  @blog.destroy
    redirect_to "/"
end

  def new
    if !current_admin
      redirect_to "/"
      end
    @blog=Blog.new
    @picture = Picture.new
    @pictures=Picture.last(5).reverse
end

  def create
    blog=Blog.new(blog_params)
    blog.admin_id = current_admin.id
    if blog.save
      redirect_to "/"
    else
      render "blogs/new"
  end
end

  private
	def blog_params
		params.require(:blog).permit(:title, :content, :admin_id)
	end

end
