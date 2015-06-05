class CreateTextresponses < ActiveRecord::Migration
  def change
    create_table :textresponses do |t|
      t.text :response
      t.string :student
      t.references :textquestion
      t.timestamps null: false
    end
  end
end
