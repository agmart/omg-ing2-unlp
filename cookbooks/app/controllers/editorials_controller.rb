class EditorialsController < ApplicationController
  before_action :set_editorial, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :check_is_admin


  # GET /editorials
  # GET /editorials.json
  def index
    @editorials = Editorial.all
  end

  # GET /editorials/1
  # GET /editorials/1.json
  def show
  end

  # GET /editorials/new
  def new
    @editorial = Editorial.new
  end

  # GET /editorials/1/edit
  def edit
  end

  # POST /editorials
  # POST /editorials.json
  def create
    @editorial = Editorial.new(editorial_params)

    respond_to do |format|
      if @editorial.save
        format.html { redirect_to @editorial, notice: 'La editorial se creó exitosamente.' }
        format.json { render action: 'show', status: :created, location: @editorial }
      else
        format.html { render action: 'new' }
        format.json { render json: @editorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /editorials/1
  # PATCH/PUT /editorials/1.json
  def update
    respond_to do |format|
      if @editorial.update(editorial_params)
        format.html { redirect_to @editorial, notice: 'La editorial se actualizó exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @editorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /editorials/1
  # DELETE /editorials/1.json
  def destroy
    @editorial.destroy
    respond_to do |format|
      format.html { redirect_to editorials_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_editorial
      @editorial = Editorial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def editorial_params
      params.require(:editorial).permit(:nombre)
    end

    def check_is_admin
      if !current_user.es_admin
        flash[:error] = 'No tenés permisos'
        redirect_to root_path
      end
    end
end
