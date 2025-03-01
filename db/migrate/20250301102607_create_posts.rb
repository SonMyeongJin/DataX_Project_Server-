class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps  # 이 줄이 created_at 및 updated_at을 자동 생성
    end
  end
end
