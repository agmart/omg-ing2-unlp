class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]


  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all
    filtering_params(params).each do |key, value|
      @purchases = @purchases.public_send(key, value) if value.present?
    end
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit
  end

  def mas_comprados
    @purchases = Purchase.all
    @mas_comprados = {}
    if filtering_params(params).empty?
      return
    end
    filtering_params(params).each do |key, value|
      @purchases = @purchases.public_send(key, value) if value.present?
    end
    # @purchases = compras del filtro de fechas
    @purchases.each do |compra|
      compra.purchase_books.each do |pb|
        @mas_comprados[pb.book_id] = @mas_comprados[pb.book_id] == nil ? pb.quantity : @mas_comprados[pb.book_id] + pb.quantity
      end
    end
    @mas_comprados.values.sort!
    @mas_comprados.first(5)
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Se creó correctamente la compra.' }
        format.json { render action: 'show', status: :created, location: @purchase }
      else
        format.html { render action: 'new' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to purchases_path, notice: 'Se actualizó la compra correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def filtering_params(params)
    params.slice(:fecha_min, :fecha_max)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def purchase_params
    params.require(:purchase).permit(:fecha, :estado, :fecha_min, :fecha_max)
  end
end
