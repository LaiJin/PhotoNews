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
    if @image_news.save
      redirect_to :image_show_view
      return
    end
    render :image_upload_view
    #redirect_to(:action => 'image_show_view', :id => @image_news.id)
  end

  def image_show_view
    #request_http_basic_authentication 让用户访问时需要验证
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
    #"HTTP_USER_AGENT"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.3 Safari/537.36"
    string = request.user_agent
    user_agent = UserAgent.parse(string)
    p '.................................'
    p  !request.user_agent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)
    p   user_agent.platform
    p   request.env['HTTP_USER_AGENT']
    p'..................................'
    @is_request_by_mac = !request.user_agent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)
    if params[:image_news_id]
      @image_news_shown = ImageNews.find(params[:image_news_id])
      return
    end
    redirect_to :image_show_view
  end

end
