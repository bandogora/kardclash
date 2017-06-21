class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Post successfully created'
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def update
    @article.assign_attributes(article_params)
    if @article.changed?
      if @article.save
        undo_link = view_context
                    .link_to('undo',
                             revert_version_path(@article.versions.last),
                             method: :post)
        flash[:success] = "Post has been updated. #{undo_link}"
        redirect_to article_path(@article)
      else
        render :edit
      end
    else
      flash[:warning] = 'No changes made to post.'
      redirect_to article_path(@article)
    end
  end

  def destroy
    @article.destroy
    undo_link = view_context
                .link_to('undo',
                         revert_version_path(@article.versions.last),
                         method: :post)
    flash[:danger] = "Post successfully deleted. #{undo_link}"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    return unless current_user != @article.user && !current_user.admin?
    flash[:danger] = "You can't mess with other user's posts!"
    redirect_to root_path
  end
end
