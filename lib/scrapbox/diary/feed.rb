# frozen_string_literal: true

require_relative "feed/version"

require "rss"
require "http"
require "time"

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
        @rss = RSS::Parser.parse(get_feed())
        self
      end

      def extract_diary_items()
        @rss.items.select do |item|
          item.description&.match(/#日記/)
        end
        .map do |item|
          item.pubDate = Time.strptime(item.title, "%Y年%m月%d日").gmtime
          item
        end
      end

      def set_channel(maker)
        maker.channel.title = strip_site_name(@rss.channel.title)
        maker.channel.link = @rss.channel.link
        maker.channel.updated = @rss.channel.pubDate
        maker.channel.description = @rss.channel.description
      end

      def strip_site_name(title)
        title.split(" - ").first
      end
    end
  end
end
