class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :add_to_cart]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  autocomplete :author, :nombre, display_value: :nombre_dni
  autocomplete :editorial, :nombre
  
  has_many :cart_book

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.habilitado = false
    @book.save!
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  def add_to_cart
    current_user.cart << @book
    current_user.cart.save!
    redirect_to @book, notice: 'Libro agregado al carro!'
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end
    def book_params
      params.require(:book).permit(:isbn, :titulo, :paginas, :precio, :ano_publicacion, :author_id, :editorial_id, :descripcion)
    end
end
