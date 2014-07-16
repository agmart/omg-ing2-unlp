# encoding: utf-8
class PagesController < ApplicationController
  before_action :check_is_admin, only: [:administracion]

  def acerca_de
  end

  def contacto
  end

  def administracion
  end

  def ayuda
  end
  
  def nuevo_admin
    @admin = User.new
  end

  def crear_admin
    @admin = User.new(user_params)
    respond_to do |format|
      if @admin.save
        format.html { redirect_to administracion_path, notice: 'Administrador creado exitosamente.' }
      else
        format.html { render action: 'nuevo_admin' }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end

  end
  
  private
    def check_is_admin
      if !current_user || !current_user.es_admin
        flash[:error] = 'No tenés permisos'
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(:email, :nombre, :dni, :direccion, :tel, :es_admin, :fecha_nac, :password, :password_confirmation)
    end
end
