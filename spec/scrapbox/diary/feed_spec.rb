# frozen_string_literal: true

RSpec.describe Scrapbox::Diary::Feed do
  it "has a version number" do
    expect(Scrapbox::Diary::Feed::VERSION).not_to be nil
  end
end
