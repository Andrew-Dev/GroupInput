class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.references :audience
      t.boolean :isMultipleChoice
      t.boolean :isActive
      t.text :questionAsJSON
      t.timestamps null: false
    end
  end
end
