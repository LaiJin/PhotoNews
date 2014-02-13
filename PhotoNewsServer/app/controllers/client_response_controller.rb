class ClientResponseController < ApplicationController

  def respond_client_request
    @image_news = ImageNews.all
    respond_to do |format|
      format.json {render :json => {:data => @image_news.to_json}}
    end
  end

end
