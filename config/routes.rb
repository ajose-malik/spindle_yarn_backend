Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# INDEX ROUTE
 get '/menwear', to: 'products#index'
 get '/womenwear', to: 'products#index'
 get '/thriftwear', to: 'products#index'
# SHOW ROUTE
get 'menwear/:id', to: 'products#show'
#CREATE ROUTE
post '/menwear', to: 'products#create'
#DELETE ROUTE
delete '/menwear/:id', to: 'products#delete'
#UPDATE ROUTE
put '/menwear/:id', to: 'products#update'

end
