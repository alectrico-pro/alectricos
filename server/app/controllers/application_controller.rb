class ApplicationController < ActionController::Base
	http_basic_authenticate_with name: "gope", password: "crisis"
end
