class ImageUploadController < ApplicationController

  SERVER_URL = 'http://0.0.0.0:3000'

  def image_upload_view
    #p '.................................'
    #p  !request.user_agent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)
    #p   request.env
    #p'..................................'
    @image_news = ImageNews.new
  end

  def upload
    @image_news = ImageNews.new
    @image_news.image = params[:image_news][:image]
    @image_news.content = params[:image_news][:content]
    @image_news.image_url = SERVER_URL + @image_news.image.url
    if @image_news.save
      redirect_to :image_show_view
      return
    end
    render :image_upload_view
    #redirect_to(:action => 'image_show_view', :id => @image_news.id)
  end

  def image_show_view
    #if params[:id]
    #  @image_news = ImageNews.find(params[:id])
    #  return
    #end
    #redirect_to :image_upload_view

    #request_http_basic_authentication 让用户访问时需要验证

   p '.................................'
   p  !request.user_agent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)
   p   request.env
   p'..................................'
    @all_image_news = ImageNews.all.reverse
  end

  def delete_image_news
    delete_image_news = ImageNews.find(params[:image_news_id])
    delete_image_news.image.destroy
    ImageNews.delete(params[:image_news_id])
    params[:image_news_id] = nil
    redirect_to :image_show_view
  end

  def show_detailed_image_news_view
    if params[:image_news_id]
      @image_news_shown = ImageNews.find(params[:image_news_id])
      return
    end
    redirect_to :image_show_view
  end

end
