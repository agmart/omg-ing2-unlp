class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :purchases, :cart]
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
    filtering_params(params).each do |key, value|
      @users = @users.public_send(key, value) if value.present?
    end
  end

  def cart
    @cart = @user.cart
    render 'carts/show' 
  end

  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def purchases
    @purchases = @user.purchases
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Usuario creado exitosamente.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Usuario actualizado exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def filtering_params(params)
    params.slice(:fecha_min, :fecha_max)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:nombre, :dni, :fecha_alta, :direccion, :tel, :email, :fecha_nac)
  end
end
