require 'sinatra' 
require 'sinatra/reloader' if development?
require 'sinatra/flash'
require 'data_mapper'
#set :port, 3000
#set :environment, :production

enable :sessions
set :session_secret, '*&(^#234a)'

configure :development do
	DataMapper.setup( :default, ENV['DATABASE_URL'] || 
                            "sqlite3://#{Dir.pwd}/mindbook.db" )
end

configure :production do   #heroku
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end

configure :test do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/test.db")
end

DataMapper::Logger.new($stdout, :debug)
DataMapper::Model.raise_on_save_failure = true 

require_relative 'model'

DataMapper.finalize

DataMapper.auto_upgrade!

get '/' do 
        erb :index
end

get '/registro' do
	erb :registro
end

post '/newUsuario' do
	session[:email] = params[:email]
	session[:login] = params[:login]
	Usuario.first_or_create(:email => params[:email],:nombre => params[:nombre],:login => params[:login],:password => params[:password])
	redirect '/home'
	
end

post '/loginUsuario' do
	if Usuario.first(:email => params[:email], :password => params[:password]) then
		session[:email] = params[:email]
		redirect '/home'
	else
		flash[:error] = "Error. El login o password son incorrectos."
                redirect '/'
	end	
end






















































