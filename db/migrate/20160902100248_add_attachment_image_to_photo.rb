class AddAttachmentImageToPhoto < ActiveRecord::Migration
  def self.up
    change_table :imageables do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :imageables, :image
  end
end
