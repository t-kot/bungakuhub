class CreateKommits < ActiveRecord::Migration
  def change
    create_table :kommits do |t|
      t.string :message
      t.string :revision

      t.timestamps
    end
  end
end
