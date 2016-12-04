class CrawlsController < ApplicationController
  before_action :authenticate_user!

  def new
    @crawl = current_user.crawls.new
  end

  def create
    Crawl.create(crawl_params)
    redirect_to root_path
  end

  def index
    @crawls = current_user.crawls
    respond_to do |format|
      format.html
      format.csv { send_data @crawls.to_csv, filename: "crawls-#{Date.today}.csv" }
    end
  end

  def update
    @crawl = Crawl.find(params[:id])
    @crawl.start_crawling
    redirect_to crawl_path(@crawl)
  end

  def show
    @crawl = Crawl.find(params[:id])
    @products = @crawl.products
  end

  def products_csv
    @crawl = Crawl.find(params[:id])
    @products = @crawl.products
    send_data @products.to_csv, filename: "products-#{Date.today}.csv"
  end

  def destroy
    @crawl = Crawl.find(params[:id])
    @crawl.destroy
    redirect_to root_path
  end

  private

  def crawl_params
    params.require(:crawl).permit(:url).merge(user_id: current_user.id)
  end
end
