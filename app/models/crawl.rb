require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

class Crawl < ActiveRecord::Base
  belongs_to :user
  has_many :products, dependent: :destroy

  validates :url, :user_id, presence: true

  after_create :start_crawling

  def self.to_csv
    attributes = %w{url crawl_time num_of_records_crawled user}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |crawl|
        csv << attributes.map { |attr| self.fetch_entry(crawl, attr) }
      end
    end
  end

  def start_crawling
    start_time = Time.now
    # allow redirection from http -> https and vice-versa
    doc = Nokogiri::HTML(open(url, allow_redirections: :all))
    product_links = get_product_links(doc)
    product_links.compact.uniq.each do |link|
      @link = link
      doc = Nokogiri::HTML(open(@link))
      extract_data_from_crawled_product_page(doc)
      create_crawled_product
    end
    t = (Time.now - start_time).to_i.abs
    update_attributes(crawl_time: t, num_of_records_crawled: products.count)
  end

  def extract_data_from_crawled_product_page(doc)
    fetch_price_and_emi_data(doc)
    fetch_name_and_brand(doc)
    fetch_color_and_image(doc)
  end

  def fetch_price_and_emi_data(doc)
    original_price_field  =  doc.search('.pdpCutPrice')
    @original_price       =  original_price_field.present? ? original_price_field.first.children.first.text.scan(/[0123456789]/).join()  : ''
    @current_price        =  doc.search('#productPrice').first.attributes['value'].value
    emi_field             =  doc.search('.emi-price')
    @emi_starts_at        =  emi_field.present? ? emi_field.first.children.text.scan(/[0123456789]/).join() : 'NA'
  end

  def fetch_name_and_brand(doc)
    @name                 =  doc.search('#productNamePDP').first.attributes['value'].value
    @brand                =  doc.search('#brandName').first.attributes['value'].value
  end

  def fetch_color_and_image(doc)
    catalog_id            =  doc.search('#catalogId').first.attributes['value'].value
    data_attrs_field      =  doc.search('#attributesJson').first.children.to_s
    if data_attrs_field.present?
      data_attrs          =  JSON.parse(data_attrs_field)
      product             =  data_attrs.select { |x| x["catalogId"] == catalog_id.to_i }.first
      @color              =  (product && product['name'] == 'Colour') ? product['value'] : ''
      @image_url          =  (product && product['thumbnail']) ? product['thumbnail'] : ''
    else
      @color              =  ""
      @image_url          =  doc.search('.cloudzoom').first.attributes['src'].value
    end

  end
  def get_product_links(doc)
    product_links = []
    doc.css("a").each do |x|
      link = x.attr('href')
      product_links << link if link && link.include?('https://www.snapdeal.com/product/')
    end
    return product_links
  end

  def create_crawled_product
    product                = self.products.where(product_url: @link).first_or_initialize
    product.name           = @name
    product.brand          = @brand
    product.original_price = @original_price
    product.current_price  = @current_price
    product.emi_starts_at  = @emi_starts_at
    product.image_url      = @image_url
    product.color          = @color
    product.save
  end

  def self.fetch_entry(crawl, attr)
    attr == 'user' ? crawl.send('user').email : crawl.send(attr)
  end
end
