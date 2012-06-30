# -*- coding: utf-8 -*-
class MainController < ApplicationController
  caches_page :diag

  def index
  end

  def diag
    begin
      twitt = Twitter.user_timeline(params[:name], :count => 200)
    rescue Twitter::Error::BadRequest
      redirect_to action: :badrequest
      return
    rescue Twitter::Error::NotFound
      redirect_to action: :notfound, name: params[:name]
      return
    end
    timing = twitt.map(&:created_at)
    weekends = timing.count {|t| t.saturday? || t.sunday? }
    weekday_nights = timing.reject {|t| t.saturday? || t.sunday? }.select { |t| t.hour >= 21 || t.hour <= 3 }.tap { |t| p t}.count
    @relate_users = twitt.select {|r| r.in_reply_to_screen_name }.
      map {|r| r.in_reply_to_screen_name }.
      inject(Hash.new(0)) {|hash, name| hash[name] += 1; hash}.tap {|a| p a}.
      sort {|a,b| b[1] <=> a[1] }.
      map {|r| r[0] }.
      take(3)

    @percent = (weekends + weekday_nights) / 2
    @message = case @percent
               when 0..10
                 'あなたは間違いなく既婚者ですね。'
               when 11..20
                 'あなたはきっと既婚者ですね。'
               when 21..30
                 'あなたは多分既婚者でしょう。'
               when 31..40
                 'あなたはおそらく独身でしょう。'
               when 41..50
                 'あなたはおそらく独身でしょう。'
               when 51..60
                 'あなたはおそらく独身でしょう。'
               when 61..70
                 '引き続き素敵な独身ライフをお送りください。'
               when 71..80
                 '引き続き素敵な独身ライフをお送りください。'
               when 81..90
                 '引きこもり過ぎではないですか。'
               when 91..100
                 '引きこもり過ぎではないですか。'
               end
  end

  def badrequest; end
  def notfound; end
  def error404; end
end
