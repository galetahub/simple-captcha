Rails.application.routes.draw do
  get "pages/form_tag"
  post "pages/form_tag" => 'pages#form_tag_submit'
  get "pages/model_tag"
  post "pages/model_tag" => 'pages#model_tag_submit'
  get "pages/formtastic_tag"
  post "pages/formtastic_tag" => 'pages#formtastic_tag_submit'
end
