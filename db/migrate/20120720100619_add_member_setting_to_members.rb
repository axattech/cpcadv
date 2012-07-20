class AddMemberSettingToMembers < ActiveRecord::Migration
  def change
    add_column :members, :member_setting, :boolean
  end
end
