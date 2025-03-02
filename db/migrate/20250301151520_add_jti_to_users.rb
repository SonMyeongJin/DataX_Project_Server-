class AddJtiToUsers < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:users, :jti)
      add_column :users, :jti, :string, default: ''
      User.reset_column_information
      User.find_each { |user| user.update_column(:jti, SecureRandom.uuid) }
      change_column :users, :jti, :string, null: false
      add_index :users, :jti, unique: true
    end
  end
end
