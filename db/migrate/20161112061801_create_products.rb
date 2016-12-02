class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :original_price, precision: 11, scale: 4
      t.decimal :current_price, precision: 11, scale: 4
      t.decimal :emi_starts_at, precision: 11, scale: 4
      t.string :image_url
      t.string :brand
      t.string :color
    end
  end
end
