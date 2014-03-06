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
      session[:title_photo_id] = @title_photo.id
      redirect_to :detail_photo_upload_view
      return
    end
    render :title_photo_upload_view
  end

  def detail_photo_upload_view
    if session[:title_photo_id]
      @detail_photo = DetailPhoto.new
      return
    end
    redirect_to :title_photo_upload_view
  end

  def upload_detail_photo
    if !params[:detail_photo][:photo] && params[:detail_photo][:content] == '' && params[:commit] == '完成'
      redirect_to(:action => :detail_photo_news_view, :title_photo_id => session[:title_photo_id])
      return
    end
    @detail_photo = DetailPhoto.new
    @detail_photo.title_photo_id = session[:title_photo_id]
    @detail_photo.photo = params[:detail_photo][:photo]
    @detail_photo.url = SERVER_URL + @detail_photo.photo.url
    @detail_photo.content = params[:detail_photo][:content]
    if @detail_photo.save
      redirect_to :detail_photo_upload_view
      return
    end
    render :detail_photo_upload_view
  end

  def delete_photo_news
    delete_photo_news = TitlePhoto.find(params[:title_photo_id])
    delete_photo_news.photo.destroy
    delete_photo_news.detail_photos.destroy_all
    TitlePhoto.delete(params[:title_photo_id])
    redirect_to :title_photo_news_list
  end

end
