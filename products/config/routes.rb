Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# INDEX ROUTE
 get '/products', to: 'products#index'
# SHOW ROUTE
get 'products/:id', to: 'products#show'
#CREATE ROUTE
post '/products', to: 'products#create'
#DELETE ROUTE
delete '/products/:id', to: 'products#delete'
#UPDATE ROUTE
put '/products/:id', to: 'products#update'

end
