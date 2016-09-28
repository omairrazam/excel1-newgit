class ActiveStudiesController < ApplicationController
 
 #load_and_authorize_resource :user, :parent => false

 authorize_resource :class => false
 
 
  def index
  	@active_studies = MarketStudy.all.order("created_at desc").page(params[:page]).per(20)
  end
end
