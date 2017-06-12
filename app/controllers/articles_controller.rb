class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = 'Article was successfully created'
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
        flash[:success] = "Article has been updated. #{undo_link}"
        redirect_to article_path(@article)
      else
        render :edit
      end
    else
      flash[:warning] = 'No changes made to article.'
      redirect_to article_path(@article)
    end
  end

  def destroy
    @article.destroy
    undo_link = view_context
                .link_to('undo',
                         revert_version_path(@article.versions.last),
                         method: :post)
    flash[:danger] = "Article successfully deleted. #{undo_link}"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
