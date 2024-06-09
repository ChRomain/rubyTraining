class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET /authors
  def index
    @authors = Author.all
  end

  # GET /authors/:id
  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # POST /authors
  def create
    author = Author.new(author_params)
    if author.save
      redirect_to authors_url, notice: 'Author created!'
    else
      render :new
    end
  end

  # GET /authors/:id/edit
  def edit
  end

  # PATCH/PUT /authors/:id
  def update
    if @author.update(author_params)
      redirect_to authors_url, notice: 'Author updated!'
    else
      render :edit
    end
  end

  # DELETE /authors/:id
  def destroy
    @author.destroy
    redirect_to authors_url, notice: 'Author destroyed!'
  end

  private
    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:name, :email)
    end
end
