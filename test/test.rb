# -*- coding: utf-8 -*-

ENV['RACK_ENV'] = 'test'
require_relative '../mindbook.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'sinatra'
require 'selenium-webdriver'
require 'rubygems'

include Rack::Test::Methods

def app
	Sinatra::Application
end

describe "test selenium pagina inicio" do

	before :all do
		@browser = Selenium::WebDriver.for :firefox
		@url = 'https://mindbooks.herokuapp.com/'
		if (ARGV[0].to_s == "localhost")
		@url = 'localhost:4567/'
	end
		@wait = Selenium::WebDriver::Wait.new(:timeout => 5)		
		@browser.get(@url)
		@browser.manage.timeouts.implicit_wait = 3
	end

	after :all do
		@browser.quit
	end

	it "se abre pagina de Inicio?" do
		assert_equal("https://mindbooks.herokuapp.com/",@browser.current_url)		
	end

	it "funciona enviar email?" do		
		begin
		element = @browser.find_element(:link,"Contacto")
		ensure
		element.click
		@browser.find_element(:id,"name2").send_keys("juan")
		@browser.find_element(:id,"email2").send_keys("juan@juan")
		@browser.find_element(:id,"message2").send_keys("mensaje de juan")
		@browser.find_element(:id,"footer-form").submit()
		assert_equal("https://mindbooks.herokuapp.com/?nombre=juan&email=juan%40juan&mensaje=mensaje+de+juan",@browser.current_url)
		end
	end

	it "registro usuarios?" do		
		begin
		element = @browser.find_element(:link,"SIGN UP")
		ensure
		element.click	
		assert_equal("https://mindbooks.herokuapp.com/registro",@browser.current_url)
		end
	end

	it "login usuarios?" do		
		begin
		element = @browser.find_element(:link,"Acceder")
		ensure
		element.click
		@browser.find_element(:id,"inputEmail3").send_keys("tony@tony")
		@browser.find_element(:id,"inputPassword3").send_keys("1234")		
		#@browser.find_element(:id,"signIn").click
		@browser.find_element(:xpath, "//button[contains(text(),'Sign in')]").click		
		assert_equal("https://mindbooks.herokuapp.com/home",@browser.current_url)
		end
	end

	
	
	
end

describe "test selenium pagina home" do

	before :all do
		@browser = Selenium::WebDriver.for :firefox
		@url = 'https://mindbooks.herokuapp.com/'
		if (ARGV[0].to_s == "localhost")
		@url = 'localhost:4567/'
	end
		@wait = Selenium::WebDriver::Wait.new(:timeout => 5)		
		@browser.get(@url)
		@browser.manage.timeouts.implicit_wait = 3
		
		#Entrada a la página home start
		element = @browser.find_element(:link,"Acceder")
		element.click
		@browser.find_element(:id,"inputEmail3").send_keys("tony@tony")
		@browser.find_element(:id,"inputPassword3").send_keys("1234")		
		#@browser.find_element(:id,"signIn").click
		@browser.find_element(:xpath, "//button[contains(text(),'Sign in')]").click
		#Entrada a la página home end
		
	end

	after :all do
		@browser.quit
	end

	it "Página nueva nota?" do	
		begin
		element = @browser.find_element(:link,"Nueva Nota")
		ensure
		element.click	
		assert_equal("https://mindbooks.herokuapp.com/notas",@browser.current_url)
		end
	end

	it "nueva nota?" do
		element = @browser.find_element(:link,"Nueva Nota")
		element.click	
		@browser.find_element(:id,"titulo").send_keys("Prueba")
		@browser.find_element(:id,"descripcion").send_keys("Pruebas selenium")
		@browser.find_element(:xpath, "//button[contains(text(),'submit')]").click
		assert_equal("https://mindbooks.herokuapp.com/home",@browser.current_url)
	end

	it "Página perfil usuario?" do	
		begin
		element = @browser.find_element(:link,"Perfil")
		ensure
		element.click	
		assert_equal("https://mindbooks.herokuapp.com/perfil",@browser.current_url)
		end
	end

	it "Página buscar nota?" do	
		begin
		element = @browser.find_element(:link,"Buscar")
		ensure
		element.click	
		assert_equal("https://mindbooks.herokuapp.com/buscar",@browser.current_url)
		end
	end

	it "nueva nota?" do
		element = @browser.find_element(:link,"Buscar")
		element.click	
		@browser.find_element(:id,"titulo").send_keys("Prueba")		
		@browser.find_element(:xpath, "//button[contains(text(),'BUSCAR')]").click
		@browser.find_element(:xpath, "//a[contains(text(),'Ver Nota')]").click
		assert_equal(@browser.title,"Contenido Nota")
	end
	
	

end
