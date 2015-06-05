class CreateMultipleChoiceQuestions < ActiveRecord::Migration
  def change
    create_table :multiple_choice_questions do |t|
      t.string :question
      t.boolean :multipleAnswers
      t.references :audience
      t.timestamps null: false
    end
  end
end
