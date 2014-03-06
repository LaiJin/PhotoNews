PhotoNewsServer::Application.routes.draw do

  #root 'user#login_view'
  get  'login' =>'user#login_view' , :as => 'login'
  post 'login' => 'user#create_login_session'
  delete 'logout' => 'user#logout', :as => 'logout'

  get 'title_photos' => 'photo_news#title_photo_news_list', :as => 'title_photo_news_list'

  get 'title_photo_upload' => 'photo_news#title_photo_upload_view', :as => 'title_photo_upload_view'
  post 'title_photo_upload' => 'photo_news#upload_title_photo'

  get 'detail_photo_news' => 'photo_news#detail_photo_news_view', :as => 'detail_photo_news_view'
  post 'detail_photo_news' => 'photo_news#upload_detail_photo_news'

  get 'detail_photo_upload' => 'photo_news#detail_photo_upload_view', :as => 'detail_photo_upload_view'
  post 'detail_photo_upload' => 'photo_news#upload_detail_photo'

  delete 'title_photos' => 'photo_news#delete_photo_news', :as => 'delete_photo_news'

end
