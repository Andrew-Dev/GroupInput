class CreateTextquestions < ActiveRecord::Migration
  def change
    create_table :textquestions do |t|
      t.string :question
      t.references :course
      t.timestamps null: false
    end
  end
end
