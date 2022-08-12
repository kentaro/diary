#!/usr/bin/env ruby

require 'scrapbox/diary/feed'

rss= RSS::Maker.make("2.0") do |maker|
  rss = Scrapbox::Diary::Feed.new(ARGV.first)
  rss.parse_feed()
  rss.set_channel(maker)

  rss.extract_diary_items().each do |orig_item|
    maker.items.new_item do |item|
      item.link = orig_item.link
      item.title = rss.strip_site_name(orig_item.title)
      item.description = orig_item.description
      item.updated = orig_item.pubDate
    end
  end
end

puts rss
