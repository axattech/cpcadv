class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
    
    t.column :email, :string
    t.column :hashed_password, :string
    t.column :last_login, :datetime
    t.column :created_at, :datetime

    end
  end
end
