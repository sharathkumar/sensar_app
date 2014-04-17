class HomeController < ApplicationController
	# respond_to :html, :json, :xml

	def index
		# respond_to do |format|
		# 	format.json { render text: "eeeee" and return}
		# 	format.html {}
		# end
		@users = User.all
		# respond_with(@users)
		 # respond_to do |format|
		 #    format.html # show.html.erb
		 #    format.json
		 #  end
	end

	def list

	end

	def show

	end
end
