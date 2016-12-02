class AddCrawlIdToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.integer :crawl_id
      t.string :product_url
    end
  end
end
