class CreateSocialProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
    	t.references :user
    	t.string :screen_name 
			t.string :relationship_status
			t.string :discoverability
			t.text :personal_info
			t.string :carrier_status 
      t.timestamps
    end
  end
end
	