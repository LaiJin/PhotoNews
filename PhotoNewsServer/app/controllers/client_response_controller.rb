class ClientResponseController < ApplicationController

  def respond_client_request
    @title_photos = TitlePhoto.all
    @title_photos =  @title_photos.reverse
    respond_to do |format|
      format.json {render :json =>  @title_photos.to_json}
    end
  end

end
