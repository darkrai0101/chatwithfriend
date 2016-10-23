class IndexController < ApplicationController
  def index
  	redirect_to inbox_path
  end
end
