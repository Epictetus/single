class MainController < ApplicationController
  caches_page :diag

  def index; end

  def diag
    twitt = Twitter.user_timeline(params[:name], :count => 200)
    timing = twitt.map(&:created_at)
    weekends = timing.count {|t| t.saturday? || t.sunday? }
    weekday_nights = timing.reject {|t| t.saturday? || t.sunday? }.select { |t| t.hour >= 21 || t.hour <= 3 }.tap { |t| p t}.count
    @percent = (weekends + weekday_nights) / 2
  end
end
