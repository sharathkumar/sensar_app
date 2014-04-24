class Beacon < ActiveRecord::Base
	establish_connection 'foo'
	self.primary_key = :uuid
end