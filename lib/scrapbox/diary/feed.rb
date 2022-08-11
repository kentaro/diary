# frozen_string_literal: true

require_relative "feed/version"

require "rss"
require "http"

module Scrapbox
  module Diary
    class Feed
      def initialize(project_name)
        @project_name = project_name
      end

      def feed_url()
        "https://scrapbox.io/api/feed/#{@project_name}"
      end

      def get_feed()
        HTTP.get(feed_url()).to_s
      end

      def parse_feed()
        RSS::Parser.parse(get_feed())
      end
    end
  end
end
