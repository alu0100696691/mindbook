source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-flash'
gem 'thin'
gem 'sinatra-contrib'
gem 'rest-client'
gem 'data_mapper'
gem 'pony'

group :development, :test do
	gem 'rspec'
	gem 'selenium-webdriver'
  	gem 'rack-test'
	gem 'rake'
	gem 'minitest'
	gem 'test-unit'
	gem 'coveralls', require: false
	gem "sqlite3"
	gem "dm-sqlite-adapter"
end

group :production do
	gem "pg"
	gem "dm-postgres-adapter"
end
