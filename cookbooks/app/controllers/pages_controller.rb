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
  private
    def check_is_admin
      if !current_user || !current_user.es_admin
        flash[:error] = 'No tenés permisos'
        redirect_to root_path
      end
    end
end
