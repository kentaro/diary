#!/usr/bin/env ruby

require 'scrapbox/diary/feed'

rss= RSS::Maker.make("2.0") do |maker|
  orig = Scrapbox::Diary::Feed.new(ARGV.first).parse_feed

  maker.channel.title = orig.channel.title
  maker.channel.link = orig.channel.link
  maker.channel.updated = orig.channel.pubDate
  maker.channel.description = orig.channel.description

  items = orig.items.select do |item|
    item.description&.match(/#日記/)
  end

  items.each do |orig_item|
    maker.items.new_item do |item|
      item.link = orig_item.link
      item.title = orig_item.title
      item.description = orig_item.description
      item.updated = orig_item.pubDate
    end
  end
end

puts rss
