class MainController < ApplicationController
  def index; end

  def diag
    @twitter = Twitter.user_timeline(params[:name])
  end
end
