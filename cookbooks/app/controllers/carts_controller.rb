class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :confirmar, :edit, :vaciar, :update, :destroy]
  before_action :authenticate_user!

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  def show
    @cart = current_user.cart
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end


  def vaciar
    @cart.cart_books.delete_all
    redirect_to cart_path(@cart), notice: 'El carro fue vaciado correctamente!'
  end

  def confirmar
    if params[:numero_tarjeta].length != 10
      flash[:error] = "El número de tarjeta debe tener 10 dígitos"
      redirect_to cart_path(@cart)
      return
    end
    if !@cart.cart_books.any?
      flash[:error] = "El carro no tiene ningún libro!"
      redirect_to cart_path(@cart)
      return
    end
    @compra = Purchase.new(estado: "Pendiente", user: current_user)
    @cart.cart_books.each do |cb|
      @compra.purchase_books << PurchaseBook.new(purchase: @compra, book: cb.book, quantity: cb.quantity)
    end

    @compra.total = params[:total]
    @cart.cart_books.delete_all
    @cart.save!
    @compra.save!
    redirect_to purchases_user_path(current_user), notice: 'Compra realizada!'
  end
  
  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart }
        format.json { render action: 'show', status: :created, location: @cart }
      else
        format.html { render action: 'new' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params[:cart, :total]
    end
end
