# encoding: utf-8
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :habilitar]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_tags, only: [:create, :update]
 
  helper_method :sort_column, :sort_direction

  autocomplete :author, :nombre, display_value: :nombre_dni
  autocomplete :editorial, :nombre
  autocomplete :tag, :nombre
  
  def index
    if params[:q]
      if request.xhr?
        # Pedido de busqueda AJAX, el del ISBN en alta de Libro
        @books = Book.where("isbn like ?", "%#{params[:q]}%")
        render :json => @books 
      else
        # Pedido de busqueda normal
        @books = Book.where("isbn like ?", "%#{params[:q]}%")
      end
    else
      # Index sin busqueda particular
      # el orden por autor hay que hacerlo a mano
      # porque no tienen el nombre, tienen el id... 
      if sort_column != "author_id"
        # Si no se ordena por autor, se puede usar sort_column
        @books = Book.order(sort_column + " " + sort_direction)
      else
        # Se ordena por autor --> a mano
        @books = Book.all
        if sort_direction == 'asc'
          @books.sort! {|a,b| a.author.nombre.downcase <=> b.author.nombre.downcase}
        else
          @books.sort! {|a,b| b.author.nombre.downcase <=> a.author.nombre.downcase}
        end
      end
      filtering_params(params).each do |key, value|
        @books = @books.public_send(key, value) if value.present?
      end
    end
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def deshabilitados
    @books = Book.where(habilitado: false)
  end

  def habilitar
    @book.habilitado = true
    @book.save!
    redirect_to deshabilitados_books_path, notice: 'El libro se habilitó correctamente'
  end

  def create
    # Si el ISBN del libro ya existe en la DB y está deshabilitado, se habilita
    try_book = Book.find_by_isbn(@bp['isbn'])
    if try_book && try_book.habilitado == false
      try_book.habilitado = true
      try_book.save!
      redirect_to try_book, notice: 'El libro ya estaba creado y se habilitó correctamente.'
      return
    end
    
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
      if @book.update(@bp)
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
      params.require(:book).permit(:isbn, :q, :titulo, :tags, :paginas, :precio, :ano_publicacion, :author_id, :editorial_id, :descripcion)
    end
    
    def filtering_params(params)
      params.slice(:isbn, :paginas_min, :paginas_max, :precio_min, :precio_max, :autor, :titulo, :ano_pub_min, :ano_pub_max)
    end
    
    def set_book
      @book = Book.find(params[:id])
    end

    def sort_column
      Book.column_names.include?(params[:sort]) ? params[:sort] : "isbn"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
