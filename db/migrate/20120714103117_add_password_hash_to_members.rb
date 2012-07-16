class AddPasswordHashToMembers < ActiveRecord::Migration
  def change
    add_column :members, :password_hash, :string
    rename_column :members, :password, :password_salt
  end
end
