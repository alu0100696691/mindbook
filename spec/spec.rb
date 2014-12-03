# -*- coding: utf-8 -*-

ENV['RACK_ENV'] = 'test'
require_relative '../mindbook.rb'
require 'rack/test'
require 'rubygems'
require 'rspec'

include Rack::Test::Methods

def app
	Sinatra::Application
end

describe "test paginas index y home" do
	
	it "se abre pagina de index?" do
		get '/'
		expect(last_response).to be_ok
	end

	it "se abre pagina de registro?" do
		get '/registro'
		expect(last_response).to be_ok
	end

	it "login de un usuario" do
		post '/loginUsuario' , params = {:email => "usuario@usuario", :password => "usuario"}
		expect(last_response.body).to eq("")
	end

	it "sesión" do
		get '/', {}, 'rack.session' => { :usuario => 'belen' }
		expect(last_response).to be_ok
	end

end
	

