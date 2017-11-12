Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'messenger#homepage'
  get 'done' => 'messenger#done' 
  post 'messenger/webhook' => 'messenger#receive_message'

end
