class CreateRepositoryTypes < ActiveRecord::Migration
  def change
    create_table :repository_types do |t|
      t.text :name

      t.timestamps
    end
  end
end
