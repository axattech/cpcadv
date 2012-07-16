class AddPicPaperclip2 < ActiveRecord::Migration
  def up
    remove_column :offers, :pic_file_name
    remove_column :offers, :pic_content_type
    remove_column :offers, :pic_file_size
    remove_column :offers, :pic_updated_at  
  end

  def down
  end
end
