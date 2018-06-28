class CommentsController < ApplicationController
  def index
  end

  def show
    @comment=Comment.find(params[:id])
  end

  def new
    @blog = Blog.find(params[:id])
    comments=Comment.find(params[:id])
    @comment=Comment.new

  end

  def create
    user=current_user
    comment=Comment.new(comment_params)
    comment.user_id =user.id
    comment.blog_id = params[:blog_id]
    if comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_to "/"
  end
end

  def edit
    user=current_user
    @comment=Comment.find(params[:id])
    if current_user
      if @comment.user_id != user.id
        redirect_to "/"
      end
    else
    redirect_to "/"
    end
end

  def update
    @comment=Comment.find(params[:id])
    if(@comment.update(comment_params))
      redirect_to comment_path
    else
      render edit_comment_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
      redirect_back(fallback_location: root_path)
  end


  private
	def comment_params
		params.require(:comment).permit(:title, :content, :user_id, :blog_id)
	end

end
