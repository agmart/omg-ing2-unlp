class PurchaseBooksController < ApplicationController
  before_action :set_purchase_book, only: [:show, :edit, :update, :destroy]

  # GET /purchase_books
  # GET /purchase_books.json
  def index
    @purchase_books = PurchaseBook.all
  end

  # GET /purchase_books/1
  # GET /purchase_books/1.json
  def show
  end

  # GET /purchase_books/new
  def new
    @purchase_book = PurchaseBook.new
  end

  # GET /purchase_books/1/edit
  def edit
  end

  # POST /purchase_books
  # POST /purchase_books.json
  def create
    @purchase_book = PurchaseBook.new(purchase_book_params)

    respond_to do |format|
      if @purchase_book.save
        format.html { redirect_to @purchase_book, notice: 'Purchase book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @purchase_book }
      else
        format.html { render action: 'new' }
        format.json { render json: @purchase_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_books/1
  # PATCH/PUT /purchase_books/1.json
  def update
    respond_to do |format|
      if @purchase_book.update(purchase_book_params)
        format.html { redirect_to @purchase_book, notice: 'Purchase book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @purchase_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_books/1
  # DELETE /purchase_books/1.json
  def destroy
    @purchase_book.destroy
    respond_to do |format|
      format.html { redirect_to purchase_books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_book
      @purchase_book = PurchaseBook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_book_params
      params.require(:purchase_book).permit(:book_id, :purchase_id)
    end
end
