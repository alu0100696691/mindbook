require 'sinatra' 
require 'sinatra/reloader' if development?
require 'sinatra/flash'
require 'data_mapper'
require 'pony'
require 'bcrypt'

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
	user = Usuario.first(:email => params[:email])
	if user && user.password == params[:password] 
		session[:email] = params[:email]
		redirect '/home'
	else
		flash[:error] = "Error. El login o password son incorrectos."
                redirect '/'
	end	
end

get '/logout' do
	session.clear
	redirect '/'
end

get '/notas' do
	erb:notas
end

get '/verNota' do
	puts "inside get '/verNota': #{params}"
	@listaNotas = Usuario.first(:email => session[:email]).notas.get(params[:id])
	erb :verNota
end

post '/modificarNota' do		
		Usuario.first(:email => session[:email]).notas.first_or_create(:id=>params[:idNota]).update(:titulo => params[:titulo],:descripcion => params[:descripcion],:notaTexto => params[:textarea_name])				
		redirect '/home'
end

get '/borrarNota' do
	puts "inside get '/verNota': #{params}"
	nota = Usuario.first(:email => session[:email]).notas.get(params[:id])
	nota.destroy
	flash[:error] = "¡¡¡Nota borrada!!!."
	redirect '/home'
end

post '/guardar' do
		Usuario.first(:email => session[:email]).notas.create(:titulo => params[:titulo],:descripcion => params[:descripcion],:notaTexto => params[:textarea_name])
		redirect '/home'
end

get '/home' do
	@listaNotas = Usuario.first(:email => session[:email]).notas.all
	erb :home	
end


get '/buscar' do
	erb :buscar
end

post '/buscarNota' do

	@listaNotas = " "
	@listaNotas = Usuario.first(:email => session[:email]).notas.all(:titulo.like => "%#{params[:titulo]}%") &
			Usuario.first(:email => session[:email]).notas.all(:descripcion.like => "%#{params[:descripcion]}%") &
			Usuario.first(:email => session[:email]).notas.all(:notaTexto.like => "%#{params[:textarea_name]}%")

	if @listaNotas == " "
		flash[:error] = "¡¡¡Nota no encontrada!!!."	
	end
	erb :buscar
end

post '/contacto' do
	mail =Pony.mail(:to => "alu0100724622@ull.edu.es", :from => params[:nombre], :subject => params[:email], :body => params[:mensaje])
	if mail	
		flash[:notice] = "¡¡¡Email enviado!!!."
	else
		flash[:error] = "¡¡¡Error. Email no enviado!!!."
	end

	erb :index
end

get '/compartir' do
	@nota = Usuario.first(:email => session[:email]).notas.get(params[:id])	
	erb :compartir
end

post '/compartirNota' do
	@nota = Usuario.first(:email => session[:email]).notas.get(params[:idNota])
	duplicar = Usuario.first(:email => params[:email]).notas.create(:titulo => @nota.titulo,:descripcion => @nota.descripcion,:notaTexto => @nota.notaTexto)
	if duplicar
		flash[:notice] = "¡¡¡Nota compartida con #{params[:email]}!!!."
	else	
		flash[:error] = "¡¡¡No se ha podido compartir nota.!!!"		
	end
	redirect '/home'
end

get '/perfil' do
	@perfil = Usuario.first(:email => session[:email])
	erb :perfil
end

post '/perfil' do
	perfil = Usuario.first(:email => session[:email])
	if perfil && params[:password] == params[:repassword]
		perfil.nombre = params[:nombre]
		perfil.email = params[:email]
		perfil.password = params[:password]
		perfil.save	
		session.clear
		session[:email] = params[:email]	
		flash[:notice] = "¡¡¡Perfil actualizado!!!."
	else
		flash[:error] = "¡¡¡No se ha podido actualizar el perfil.!!!"	
	end
	redirect '/home'
end
















































