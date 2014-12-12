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

describe "test selenium pagina registro" do

	before :all do
		@browser = Selenium::WebDriver.for :firefox
		@url = 'https://mindbooks.herokuapp.com/'
		if (ARGV[0].to_s == "localhost")
		@url = 'localhost:4567/'
	end
		@browser.get(@url)
	end

	it "se abre pagina de Inicio?" do
		assert_equal("https://mindbooks.herokuapp.com/",@browser.current_url)
		@browser.quit
	end
end
