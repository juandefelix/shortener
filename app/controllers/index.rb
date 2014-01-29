get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/urls' do
  erb :create
end

post '/create' do
  if Url.create!( long_url: params["long"], short_url: params["short"], counter: 0).valid?
    erb :index
  else
    "Long URL must be a valid URL\nShort URL and Long URL must be unique."
  end

end

get '/:short_url' do
  # redirect to appropriate "long" URL
  u = Url.where(short_url: params[:short_url]).first
  u.counter += 1
  u.save
  redirect "#{u.long_url}"
end
