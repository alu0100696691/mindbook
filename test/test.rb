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

	
end
