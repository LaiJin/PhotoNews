class PhotoNewsController < ApplicationController

  def title_photo_news_list
    if current_user
      @title_photos = TitlePhoto.all
      return
    end
    redirect_to :login
  end

  def detail_photo_news_view
  end

  def title_photo_upload_view
    if current_user
      @title_photo = TitlePhoto.new
      return
    end
    redirect_to :login
  end

  def upload_title_photo
    @title_photo = TitlePhoto.new(params[:title_photo])
    if @title_photo.save
      redirect_to :title_photos
      return
    end
    redirect_to :title_photo_upload_view
  end

end
