class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
		t.string   :user_name
      t.string   :activity_name
      t.text   :activity_desc
      t.integer  :like,:default => 0
      t.string   :cached_tag_list
      t.timestamps
      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
