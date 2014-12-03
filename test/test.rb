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
