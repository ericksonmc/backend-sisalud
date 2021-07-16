class Api::V1::ProductsController < ApplicationController
  before_action :find_product
  def index 
    render json: Product.all
  end

  def update
    if @product.update(product_params)
      render json: { message: 'Producto actualizado con exito', status: 'ok' }
    else
      render json: { message: 'Ocurrio un erro al actualizar el producto',
                     erros: @product.errors.messages , status: 'fail' }, status: 400 and return
    end
  end

  private

  def product_params
    params.permit(:title, :description)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
