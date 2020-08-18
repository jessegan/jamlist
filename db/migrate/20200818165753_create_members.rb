class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.references :user
      t.references :group
      t.boolean :admin
      t.boolean :creator

      t.timestamps
    end
  end
end
