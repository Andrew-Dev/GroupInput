class CreateMultipleChoiceResponses < ActiveRecord::Migration
  def change
    create_table :multiple_choice_responses do |t|
      t.references :multiple_choice_answer
      t.string :student
      t.timestamps null: false
    end
  end
end
