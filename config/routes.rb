Rails.application.routes.draw do
  #get 'rules/index'
  resources :kittens



  #scope '', as: 'kittens' do
  #  scope 'projects/:project_id', as: 'project' do
  #    resources :kittens

  #  end
  #end


  scope 'projects/:project_id' do
    resources :risks#, only: [:new, :create, :index]
  end

  scope 'projects/:project_id' do
    resources :risk_rules#, only: [:new, :create, :index]
  end

  scope 'projects/:project_id' do
    resources :project_rules#, only: [:new, :create, :index]
  end
  #resources :risks
  
end



