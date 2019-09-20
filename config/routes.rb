Rails.application.routes.draw do
  resources :kittens



  #scope '', as: 'kittens' do
  #  scope 'projects/:project_id', as: 'project' do
  #    resources :kittens

  #  end
  #end

  resources :risks
end
