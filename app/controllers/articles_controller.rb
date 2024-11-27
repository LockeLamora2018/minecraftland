class ArticlesController < ApplicationController
  include Paginable

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[edit update destroy]
  before_action :set_categories, only: %i[new create edit update ]

  def index
    @categories = Category.sorted
    category = @categories.select {|c| c.name == params[:category]} [0] if params[:category].present?

    @highlights = Article.includes(:category, :user)
                         .filter_by_category(category)
                         .desc_order
                         .first(3)

    highlights_ids = @highlights.any? ? @highlights.pluck(:id).join(',') : nil

    @articles = Article.includes(:category, :user)
                       .without_highlights(highlights_ids)
                       .filter_by_category(category)
                       .desc_order
                       .page(current_page)
  end

  def show
    @article = Article.includes(comments: :user).find(params[:id])
    authorize @article
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article, notice: "Artigo criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Artigo atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, notice: "Artigo excluído com sucesso."
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :category_id)
  end

  def set_article
    @article = Article.find(params[:id])
    authorize @article
  end

  def set_categories
    @categories = Category.sorted
  end
end