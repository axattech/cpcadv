class RenameMemberSettingToMemberDetail < ActiveRecord::Migration
  def up
    rename_column :members, :member_setting, :member_detail
  end

  def down
     rename_column :members, :member_detail, :member_setting
  end
end
