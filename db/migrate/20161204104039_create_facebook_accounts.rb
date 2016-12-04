class CreateFacebookAccounts < ActiveRecord::Migration
  def change
    create_table :facebook_accounts do |t|
      t.integer :user_id
      t.string :uid
      t.string :token

      t.timestamps null: false
    end
  end
end
