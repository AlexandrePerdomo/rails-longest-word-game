Rails.application.routes.draw do
  get 'game' => 'game#game'

  get 'score' => 'game#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
