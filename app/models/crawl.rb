require 'nokogiri'
require 'open-uri'

class Crawl < ActiveRecord::Base
  belongs_to :user
  has_many :products, dependent: :destroy

  validates :url, :user_id, presence: true

  after_create :start_crawling

  def start_crawling
    doc = Nokogiri::HTML(open(url))
    all_links = []
    product_links = []
    doc.css("a").each { |x| all_links << x.attr('href') }
    all_links.compact!
    all_links.each  { |x| product_links << x if x.include?('https://www.snapdeal.com/product/') }
    product_links.each do |link|
      doc = Nokogiri::HTML(open(link))
      catalog_id           =  doc.search('#catalogId').first.attributes['value'].value
      original_price_field =  doc.search('.pdpCutPrice')
      original_price       =  original_price_field.first.children.first.text.scan(/[0123456789]/).join() if original_price_field.present?
      current_price        =  doc.search('#productPrice').first.attributes['value'].value
      name                 =  doc.search('#productNamePDP').first.attributes['value'].value
      brand                =  doc.search('#brandName').first.attributes['value'].value
      data_attrs_field     =  doc.search('#attributesJson').first.children.to_s
        if data_attrs_field.present?
        data_attrs         =  JSON.parse(data_attrs_field)
        product            =  data_attrs.select { |x| x["catalogId"] == catalog_id.to_i }.first
        color              =  product['value'] if product['name'] == 'Colour'
        image_url          =  product['thumbnail']
      else
        color              =  ""
        image_url          =  doc.search('.cloudzoom').first.attributes['src'].value
      end
      emi_field            =  doc.search('.emi-price')
      emi_starts_at        =  emi_field.first.children.text.scan(/[0123456789]/).join() if emi_field.present?
      self.products.create(
                       product_url: link,
                       name: name,
                       original_price: original_price,
                       current_price: current_price,
                       emi_starts_at: emi_starts_at,
                       image_url: image_url,
                       brand: brand,
                       color: color
                     )
    end
  end
end
