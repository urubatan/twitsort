# encoding: utf-8
require 'twitter'
require 'pry'

module Twitsort
  class Searcher
    def initialize(follow, text)
      @follow = follow
      @text = text
    end

    def search
      res = []
      query = nil
      current_page = 1
      begin
        query = Twitter.search(@text, :rpp => 100, :page => current_page)
        query.results.each do |status|
          res << {:from_user => status.from_user, :from_user_name => status.from_user_name}
        end
        current_page = query.next_page.gsub(/.*page=([0-9]+).*/,'\1') if query.next_page
      end while query.next_page
      res.select {|stat| following_me?(stat[:from_user]) }
    end
    def any_random
      res = search
      res[rand(res.length)]
    end
    def following_me?(name)
      true
    end
  end
end
s = Twitsort::Searcher.new('urubatan', 'Quero ganhar o livro do @urubatan autografado (http://bit.ly/OulSOF), quer ganhar também? da uma olhada neste link http://bit.ly/MVXl5b')
result = s.any_random
puts "@#{result[:from_user]} - #{result[:from_user_name]}"