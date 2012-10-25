class AddForkedFromToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :forked_from, :integer
  end
end
