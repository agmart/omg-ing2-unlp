class CartBooksController < ApplicationController
  before_action :set_cart_book, only: [:show, :edit, :update, :destroy]

  # GET /cart_books
  # GET /cart_books.json
  def index
    @cart_books = CartBook.all
  end

  # GET /cart_books/1
  # GET /cart_books/1.json
  def show
  end

  # GET /cart_books/new
  def new
    @cart_book = CartBook.new
  end

  # GET /cart_books/1/edit
  def edit
  end

  # POST /cart_books
  # POST /cart_books.json
  def create
    @cart = current_user.cart
    book = Book.find(params[:book_id])
    @cart_book = @cart.add_product(book)

    respond_to do |format|
      if @cart_book.save
        format.html { redirect_to @cart_book.cart, notice: 'El libro se agregó correctamente al carro.' }
        format.json { render action: 'show', status: :created, location: @cart_book }
      else
        format.html { render action: 'new' }
        format.json { render json: @cart_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cart_books/1
  # PATCH/PUT /cart_books/1.json
  def update
    respond_to do |format|
      if @cart_book.update(cart_book_params)
        format.html { redirect_to @cart_book, notice: 'Cart book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_books/1
  # DELETE /cart_books/1.json
  def destroy
    @cart_book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_book
      @cart_book = CartBook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_book_params
      params.require(:cart_book).permit(:book_id, :cart_id)
    end
end
