class ClientResponseController < ApplicationController

  def respond_client_request
    @image_news = ImageNews.all
    @image_news =  @image_news.reverse
    respond_to do |format|
      format.json {render :json =>  @image_news.to_json}
    end
  end

end
