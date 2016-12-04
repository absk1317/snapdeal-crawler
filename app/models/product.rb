class Product < ActiveRecord::Base
  belongs_to :crawl

  def self.to_csv
    attributes = %w{name original_price current_price emi_starts_at image_url brand color product_url}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |product|
        csv << attributes.map do |attr|
          product.send(attr)
        end
      end
    end
  end
end
