class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @comments = Comment.paginate(page: params[:page], per_page: 10)
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = @current_user
    if @comment.save
      flash[:success] = 'Reply created'
    end
    redirect_back(fallback_location: declarations_path)
  end

  def update
    @comment.assign_attributes(comment_params)
    if @comment.changed?
      if @comment.save
        undo_link = view_context
                    .link_to('undo',
                             revert_version_path(@comment.versions.last),
                             method: :post)
        flash[:success] = "Comment updated. #{undo_link}"
      end
    else
      flash[:warning] = 'No changes made to comment.'
    end
    redirect_back(fallback_location: declarations_path)
  end

  def destroy
    @comment.destroy
    undo_link = view_context
                .link_to('undo',
                         revert_version_path(@comment.versions.last),
                         method: :post)
    flash[:danger] = "Comment deleted. #{undo_link}"
    redirect_back(fallback_location: declarations_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :declaration_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def require_same_user
    return unless current_user != @comment.user && !current_user.admin?
    flash[:danger] = "You can't mess with other user's comments!"
    redirect_to root_path
  end
end