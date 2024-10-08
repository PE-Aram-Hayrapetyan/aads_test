class CreateUserFriendsRelations < ActiveRecord::Migration[7.1]
  def change
    create_table :user_friends_relations, id: :uuid do |t|
      t.references :user, null: false, type: :uuid
      t.references :other_user, null: false, type: :uuid
      t.boolean :confirmed, default: false

      t.timestamps
    end

    add_foreign_key :user_friends_relations, :users, column: :user_id, primary_key: :id
    add_foreign_key :user_friends_relations, :users, column: :other_user_id, primary_key: :id
  end
end
