require File.expand_path(File.join(*%w[ config env ]), File.dirname(__FILE__))

run Emailer::App.new
