require 'bundler'
Bundler.require


ActiveRecord::Base.establish_connection({
  adapter: 'postgresql',
  database: 'restaurant'
  })

Dir['models/*.rb'].each do |file|
  require_relative file
end

  get '/console' do
    Pry.start(binding)
    ""
  end

  # Default route
  get '/' do
    erb :index
  end

  get '/foods' do
    @foods = Food.all
    erb :'foods/index'
  end

  get '/foods/new' do
    erb :'foods/new'
  end

  get '/foods/:id' do
    @food = Food.find(params[:id])
    erb :'foods/show'
  end

  post '/foods' do
    new_name = params['food_name']
    Food.create({name: new_name})
    redirect '/foods'
  end

  get '/foods/:id/edit' do
    @food = Food.find(params[:id])
    erb :'foods/edit'
  end

  patch '/foods/:id' do
    food = Food.find(params[:id])
    food.update(params[:food])
    redirect to "/foods/#{food.id}"
  end

  delete '/foods/:id' do
    food = Food.find(params[:id])
    food.destroy
    redirect to '/foods'
  end

  get '/parties' do
    @parties = Party.all
    erb :'parties/index'
  end

  get '/parties/new' do
    @parties = Party.all
    @available = Party.open_tables
    erb :'parties/new'
  end

  get '/parties/:id' do
    @party = Party.find(params[:id])
    erb :'parties/show'
  end

  post '/parties' do
    party = Party.create(params[:party])
    redirect to '/parties'
  end

  get '/parties/:id/edit' do
    @party = Party.find(params[:id])
    @foods = Food.all
    erb :'parties/edit'
  end

  patch '/parties/:id' do
    party = Party.find(params[:id])
    party.update(params[:party])
    redirect to "/parties/#{party.id}"
  end

  delete '/parties/:id' do
    party = Party.find(params[:id])
    party.destroy

    redirect to '/parties'
  end

  get '/orders' do
    @orders = Order.all
    erb :'orders/index'
  end


  post '/parties/:party_id/order' do
    @order = Order.create(params[:order])
    @order.party_id = :party_id
    erb :'parties/edit'

  end

  patch '/parties/:party_id/order' do
    party = Party.find(params[:party_id])
    party.update(params[:party])

    redirect to "/parties/#{party.id}"
  end

  # patch '/parties/:id/checkout' do
  #
  # end
  #
  # get 'parties/:id/receipt' do
  #
  # end

  get '/orders/new' do
    @orders = Order.all
    erb :'orders/new'
  end

  get '/orders/:id' do
    @order = Order.find(params[:id])
    erb :'orders/show'
  end

  post '/orders' do
    order = Order.create(params[:order])
    redirect to 'orders/#{order.id}'
  end

  get '/orders/:id/edit' do
    @order = Order.find(params[:id])
    erb :'orders/edit'
  end

  patch '/orders/:id' do
    order = Order.find(params[:id])
    order.update(params[:order])
    redirect to '/orders/#{order.id}'
  end

  delete '/orders/:id' do
    order = Order.find(params[:id])
    order.destroy

    redirect to '/orders'
  end

  # Redirect to default route should all else fail
  get '/*' do
    redirect to '/'
  end

  # post '/foods' do
  #   foods = Food.create(params[:food])
  #   redirect to 'foods/#{food.id}'
  # end
