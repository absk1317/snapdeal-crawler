class Product < ActiveRecord::Base
  belongs_to :crawl

  validates :name, :original_price, :current_price, :image_url, presence: true
end
