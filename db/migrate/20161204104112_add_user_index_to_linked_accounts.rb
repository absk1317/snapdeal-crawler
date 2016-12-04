class AddUserIndexToLinkedAccounts < ActiveRecord::Migration
  def change
    add_index :facebook_accounts, :user_id
    add_index :google_accounts, :user_id
  end
end
