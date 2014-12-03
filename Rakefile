task :default => :tests

desc "run the chat server"
task :server do
  sh "bundle exec ruby mindbook.rb"
end

desc "Visit the GitHub repo page"
task :open do
  sh "open https://github.com/crguezl/chat-blazee"
end

desc "Run tests"
task :tests  => :spec do
	sh "ruby test/test.rb"
end

desc "tests spec"
task :spec do
	sh "bundle exec rspec -I. spec/spec.rb"
end



