class AddJtiToUsers < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:users, :jti)
      add_column :users, :jti, :string
      User.reset_column_information # 필요한 경우
      User.find_each { |user| user.update_column(:jti, SecureRandom.uuid) }
      change_column_null :users, :jti, false
      add_index :users, :jti, unique: true
    end
  end
end
