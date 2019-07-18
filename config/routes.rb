Rails.application.routes.draw do
  get '/*query', to: "anagrams#show", as: :anagrams_show
end
