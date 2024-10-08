class CreateDashboardPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_posts, id: :uuid do |t|
      t.integer :visibility
      t.text :content
      t.belongs_to :dashboard_post, null: true, foreign_key: true, type: :uuid
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
