class DeleteCreatorFromMembers < ActiveRecord::Migration[6.0]
  def change
    remove_column :members, :creator, :boolean
  end
end
