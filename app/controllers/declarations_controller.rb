class DeclarationsController < ApplicationController
  before_action :set_declaration, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @declarations = Declaration.paginate(page: params[:page], per_page: 10)
  end

  def new
    @declaration = Declaration.new
  end

  def create
    @declaration = Declaration.new(declaration_params)
    @declaration.user = current_user
    if @declaration.save
      flash[:success] = 'Post successfully created'
      redirect_to declaration_path(@declaration)
    else
      render :new
    end
  end

  def update
    @declaration.assign_attributes(declaration_params)
    if @declaration.changed?
      if @declaration.save
        undo_link = view_context
                    .link_to('undo',
                             revert_version_path(@declaration.versions.last),
                             method: :post)
        flash[:success] = "Post has been updated. #{undo_link}"
        redirect_to declaration_path(@declaration)
      else
        render :edit
      end
    else
      flash[:warning] = 'No changes made to post.'
      redirect_to declaration_path(@declaration)
    end
  end

  def destroy
    @declaration.destroy
    undo_link = view_context
                .link_to('undo',
                         revert_version_path(@declaration.versions.last),
                         method: :post)
    flash[:danger] = "Post successfully deleted. #{undo_link}"
    redirect_to declarations_path
  end

  private

  def declaration_params
    params.require(:declaration).permit(:title, :description)
  end

  def set_declaration
    @declaration = Declaration.find(params[:id])
  end

  def require_same_user
    return unless current_user != @declaration.user && !current_user.admin?
    flash[:danger] = "You can't mess with other user's posts!"
    redirect_to root_path
  end
end
