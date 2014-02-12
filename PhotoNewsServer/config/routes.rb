PhotoNewsServer::Application.routes.draw do

  root 'image_upload#image_upload_view', :as => 'image_upload_view'

  post 'image_upload/image_upload_view' => 'image_upload#upload'
  get  'image_upload/image_show_view', :as => 'image_show_view'
  get  'image_news_data' => 'client_response#respond_client_request'

end
