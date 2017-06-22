class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  before_action :require_same_user, only: %i[edit update]
  before_action :require_admin, only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Account updated'
      redirect_to declarations_path
    else
      render 'edit'
    end
  end

  def show
    @user_declarations = @user.declarations.paginate(page: params[:page],
                                                     per_page: 10)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    undo_link = view_context
                .link_to('undo',
                         revert_version_path(@user.versions.last),
                         method: :post)
    flash[:danger] = "User destroyed. #{undo_link}"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    return unless current_user != @user && !current_user.admin?
    flash[:danger] = "You can't mess with other users!"
    redirect_to root_path
  end

  def require_admin
    return unless logged_in? && !current_user.admin?
    flash[:danger] = 'Only admins are allowed to do this.'
    redirect_to root_path
  end
end