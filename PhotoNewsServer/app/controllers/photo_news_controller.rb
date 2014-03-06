class PhotoNewsController < ApplicationController

  SERVER_URL = 'http://0.0.0.0:3000'

  def title_photo_news_list
    if current_user
      @title_photos = TitlePhoto.all
      return
    end
    redirect_to :login
  end

  def detail_photo_news_view
    if params[:title_photo_id]
      string = request.user_agent
      user_agent = UserAgent.parse(string)
      @is_request_by_iphone = user_agent.platform == 'iPhone'
      @detail_photos = TitlePhoto.find(params[:title_photo_id]).detail_photos
      return
    end
    redirect_to :title_photo_news_list
  end

  def title_photo_upload_view
    if current_user
      @title_photo = TitlePhoto.new
      return
    end
    redirect_to :login
  end

  def upload_title_photo
    @title_photo = TitlePhoto.new
    @title_photo.photo = params[:title_photo][:photo]
    @title_photo.title = params[:title_photo][:title]
    @title_photo.synopsis = params[:title_photo][:synopsis]
    @title_photo.url = SERVER_URL + @title_photo.photo.url
    if @title_photo.save
      redirect_to :title_photo_news_list
      return
    end
    render :title_photo_upload_view
  end

  def detail_photo_upload_view
    if current_user
      @detail_photo = DetailPhoto.new
    end
  end

end
