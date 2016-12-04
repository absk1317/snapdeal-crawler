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
    # @new_crawl = current_user.crawls.new
    @crawls = current_user.crawls
  end

  def show
    @crawl = Crawl.find(params[:id])
    @products = @crawl.products
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
