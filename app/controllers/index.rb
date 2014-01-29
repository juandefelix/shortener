require 'pry'

get '/' do
  # Look in app/views/index.erb
  erb :index
end


get '/create_user' do
  erb :create_user
end


post '/create_user' do
  User.create(email: params["email"], password: params["password"])
  redirect '/'
end


get '/urls' do
  erb :create
end





post '/login' do
  user = User.where(email: params[:email]).first
  session[:id] = user.id
  redirect '/logedin' if User.login(params["email"], params["password"]) != nil

end


get '/logedin' do
  @user_id = session[:id]
  erb :logedin
end

post '/create' do
  @user_id = session[:id]
  if Url.create!( long_url: params["long"], short_url: params["short"], user_id: @user_id, counter: 0).valid?
    erb :logedin
  else
    "Long URL must be a valid URL\nShort URL and Long URL must be unique."
  end
end


get '/logout' do
  session.clear
  redirect '/'
end


get '/:short_url' do
  # redirect to appropriate "long" URL
  u = Url.where(short_url: params[:short_url]).first
  u.counter += 1
  u.save
  redirect "#{u.long_url}"
end


