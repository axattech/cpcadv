class AddGenderToMemberse < ActiveRecord::Migration
  def change
    add_column :members, :gender, :string
    add_column :members, :age, :integer
  end
end
