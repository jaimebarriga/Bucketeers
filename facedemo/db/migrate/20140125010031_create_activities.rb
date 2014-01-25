class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :desc
      t.references :tag
      t.references :user
      t.string :state

      t.timestamps
    end
    add_index :activities, :tag_id
    add_index :activities, :user_id
  end
end
