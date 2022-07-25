class DropStudios < ActiveRecord::Migration[5.2]
  def change
    drop_table :studios
  end
end
