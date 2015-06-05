class AddClientToMcResponse < ActiveRecord::Migration
  def change
  	remove_column :multiple_choice_responses, :client
  	change_table :multiple_choice_responses do |t|
    	t.references :client
  	end
  end
end
