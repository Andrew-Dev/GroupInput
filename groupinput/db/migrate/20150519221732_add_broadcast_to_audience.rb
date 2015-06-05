class AddBroadcastToAudience < ActiveRecord::Migration
  def change
  	add_column :audiences, :broadcast, :string
  end
end
