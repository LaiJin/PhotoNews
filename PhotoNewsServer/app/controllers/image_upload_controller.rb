class ImageUploadController < ApplicationController

  SERVER_URL = 'http://0.0.0.0:3000'

  def image_upload_view
    @image_news = ImageNews.new
  end

  def upload
    @image_news = ImageNews.new
    @image_news.image = params[:image_news][:image]
    @image_news.content = params[:image_news][:content]
    @image_news.image_url = SERVER_URL + @image_news.image.url
    @image_news.save
    redirect_to :image_show_view
    #redirect_to(:action => 'image_show_view', :id => @image_news.id)
  end

  def image_show_view
    #if params[:id]
    #  @image_news = ImageNews.find(params[:id])
    #  return
    #end
    #redirect_to :image_upload_view
    @all_image_news = ImageNews.all.reverse
  end

end
