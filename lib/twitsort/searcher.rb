require 'twitter'

module Twitsort
  class Searcher
    def initialize(follow, text)
      @follow = follow
      @text = text
    end

    def search
      res = []
      query = Twitter.search(@text)
      query.results.each do |status|
        res = {:from_user => status.from_user, :from_user_name => status.from_user_name}
      end

      res.select {|stat| following_me?(stat[:from_user]) }
    end

    def following_me?(name)
      true
    end
  end
end
