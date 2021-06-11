class ApplicationController < ActionController::Base
  def hello
    render html: "Hello, World!...Goodbye"
  end
end
