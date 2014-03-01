require_relative "./config/boot"
require File.join(RACK_ROOT, "app", "app")

run Emailer::App.new
