class RemovePicPaperclip < ActiveRecord::Migration
   def up
    remove_column :offers, :offer_image
  end

  def down
    remove_column :offers, :offer_image
  end

end
