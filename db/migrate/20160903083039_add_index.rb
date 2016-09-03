class AddIndex < ActiveRecord::Migration
  def change
  	add_index :imageables, :post_id
  end
end
