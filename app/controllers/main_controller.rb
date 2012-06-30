class MainController < ApplicationController
  def index; end

  def diag
    params[:name]
  end
end
