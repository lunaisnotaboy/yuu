require 'rails_helper'

RSpec.describe SiteAnnouncementsFeed, type: :model do
  describe '#setup!' do
    it 'makes the feed follow the global' do
      feed = described_class.new('5554')
      expect(feed).to receive(:follow).with(SiteAnnouncementsGlobalFeed.new, scrollback: 1)
                                      .once
      feed.setup!
    end
  end
end
