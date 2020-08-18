class AddOwnerToGroups < ActiveRecord::Migration[6.0]
  def change
    add_reference :groups, :owner, foreign_key: {to_table: :users}
  end
end
