class ChangeNameAtSex < ActiveRecord::Migration
  def up
    change_column :sexes, :name, :text
  end

  def down
    change_column :sexes, :name, :string
  end
end
