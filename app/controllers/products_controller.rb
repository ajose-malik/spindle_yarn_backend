class ProductsController < ApplicationController


# INDEX METHOD
    def index
        render  json: Product.all
    end


# SHOW METHOD
    def show
       render json: Product.find(params['id'])
    end
# CREATE METHOD
    def create
        render json: Product.create(params['product'])

    end
# DELETE METHOD
    def delete
        render json: Product.delete(params['id'])
    end
# UPDATE METHOD
   def update
       render json: Product.update(params['id'], params['product'])

   end
end
