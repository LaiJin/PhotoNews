PhotoNewsServer::Application.routes.draw do


  #root 'user#login_view'
  get  'login' =>'user#login_view' , :as => 'login'
  post 'login' => 'user#create_login_session'

  get  'image_upload/image_upload_view' => 'image_upload#image_upload_view', :as => 'image_upload_view'
  post 'image_upload/image_upload_view' => 'image_upload#upload'
  get  'image_upload/image_show_view', :as => 'image_show_view'
  get  'image_upload/show_detailed_image_news_view' => 'image_upload#show_detailed_image_news_view', :as => 'show_detailed_image_news_view'
  get  'image_news_data' => 'client_response#respond_client_request'
  delete 'image_upload/image_show_view' => 'image_upload#delete_image_news', :as => 'delete_image_news'
  delete 'logout' => 'user#logout', :as => 'logout'

end
