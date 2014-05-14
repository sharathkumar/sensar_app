class CreateBusinessProfiles < ActiveRecord::Migration
  def change
    create_table :business_profiles do |t|
      t.references :user
      t.string :business_name
      t.string :skills
      t.string :discoverability
      t.text :business_info
      t.string :website
      t.timestamps
    end
  end
end
