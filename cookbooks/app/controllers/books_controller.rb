# encoding: utf-8
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_tags, only: [:create]
  
  autocomplete :author, :nombre, display_value: :nombre_dni
  autocomplete :editorial, :nombre
  autocomplete :tag, :nombre
  
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
    @book = Book.new(@bp)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'El libro se creó correctamente.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_tags
    # Chanchada enorme porque no entiendo cómo funciona el plugin
    # p*to de autocompletar con colecciones
    # Los parámetros deberían pasar como Array por el formulario pero los
    # arma como un string --> se parte el string de tags y se busca los tags en la DB y se arma un array
    # con eso, para crear el libro con los objetos Tag ya agarrados
    # Puede fallar (?)
    tags_params = book_params['tags'].split(" ")
    tags = []
    tags_params.each do |t| 
      tag = Tag.find_by_nombre(t)
      tags << tag if tag
    end
    @bp = book_params
    @bp['tags'] = tags
  end
  
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Se actualizó el libro correctamente.' }
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

  private
    def book_params
      params.require(:book).permit(:isbn, :titulo, :tags, :paginas, :precio, :ano_publicacion, :author_id, :editorial_id, :descripcion)
    end
    def set_book
      @book = Book.find(params[:id])
    end
end
