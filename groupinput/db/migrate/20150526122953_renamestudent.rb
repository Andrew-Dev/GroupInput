class Renamestudent < ActiveRecord::Migration
  def change
  	rename_column :multiple_choice_responses, :student, :client
  end
end
