# encoding: utf-8

class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :check_is_admin

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.order("nombre ASC")
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'El autor se creó exitosamente. '}
        format.json { render action: 'show', status: :created, location: @author }
      else
        format.html { render action: 'new' }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'El autor se actualizó exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:nombre, :dni)
    end

    def check_is_admin
      if !current_user || !current_user.es_admin
        flash[:error] = 'No tenés permisos'
        redirect_to root_path
      end
    end
end
