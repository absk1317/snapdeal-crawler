class CreateCrawls < ActiveRecord::Migration
  def change
    create_table :crawls do |t|
      t.string :url
      t.integer :user_id
      t.integer :num_of_records_crawled
      t.integer :crawl_time #in seconds
    end
  end
end
