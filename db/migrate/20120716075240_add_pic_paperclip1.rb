class AddPicPaperclip1 < ActiveRecord::Migration
  def self.up
      add_column :offers, :pic_file_name,    :string
      add_column :offers, :pic_content_type, :string
      add_column :offers, :pic_file_size,    :integer
      add_column :offers, :pic_updated_at,   :datetime
  end
 
  def self.down
    remove_column :offers, :pic_file_name
    remove_column :offers, :pic_content_type
    remove_column :offers, :pic_file_size
    remove_column :offers, :pic_updated_at
  end
  
end
