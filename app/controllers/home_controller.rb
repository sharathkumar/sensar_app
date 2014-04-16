class HomeController < ApplicationController
	def index
		respond_to do |format|
			format.json { render text: "eeeee" and return}
			format.html {}
		end
	end

	def list
		respond_to do |format|
			format.json {}
			format.html {}
		end
	end
end
