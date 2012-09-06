class AddPicPaperclip < ActiveRecord::Migration
  def up
    add_column :offers, :offer_image, :string
  end

  def down
    remove_column :offers, :offer_image,  :string
  end
end
