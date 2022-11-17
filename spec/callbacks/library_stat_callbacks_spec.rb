require 'rails_helper'

RSpec.describe LibraryStatCallbacks do
  subject { described_class.new(entry) }

  let(:anime) { build(:anime) }
  let(:manga) { build(:manga) }
  let(:user) { create(:user) }

  def include_a_job_matching(*args)
    include(a_hash_including('args' => args))
  end

  context 'with Manga' do
    let(:entry) { build(:library_entry, manga: manga, user: user) }

    before { allow(StatWorker).to receive(:perform_async) }

    describe '#after_update' do
      it 'queues a worker to update Stat::MangaCategoryBreakdown' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::MangaCategoryBreakdown', user, :update, entry)
        subject.after_update
      end

      it 'queues a worker to update Stat::MangaAmountConsumed' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::MangaAmountConsumed', user, :update, entry)
        subject.after_update
      end
    end

    describe '#after_create' do
      it 'queues a worker to create Stat::MangaCategoryBreakdown' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::MangaCategoryBreakdown', user, :create, entry)
        subject.after_create
      end

      it 'queues a worker to create Stat::MangaAmountConsumed' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::MangaAmountConsumed', user, :create, entry)
        subject.after_create
      end
    end

    describe '#after_destroy' do
      it 'queues a worker to destroy Stat::MangaCategoryBreakdown' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::MangaCategoryBreakdown', user, :destroy, entry)
        subject.after_destroy
      end

      it 'queues a worker to destroy Stat::MangaAmountConsumed' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::MangaAmountConsumed', user, :destroy, entry)
        subject.after_destroy
      end
    end
  end

  context 'with Anime' do
    let(:entry) { build(:library_entry, anime: anime, user: user) }

    before { allow(StatWorker).to receive(:perform_async) }

    describe '#after_update' do
      it 'queues a worker to update Stat::AnimeCategoryBreakdown' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::AnimeCategoryBreakdown', user, :update, entry)
        subject.after_update
      end

      it 'queues a worker to update Stat::AnimeAmountConsumed' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::AnimeAmountConsumed', user, :update, entry)
        subject.after_update
      end
    end

    describe '#after_create' do
      it 'queues a worker to create Stat::AnimeCategoryBreakdown' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::AnimeCategoryBreakdown', user, :create, entry)
        subject.after_create
      end

      it 'queues a worker to create Stat::AnimeAmountConsumed' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::AnimeAmountConsumed', user, :create, entry)
        subject.after_create
      end
    end

    describe '#after_destroy' do
      it 'queues a worker to destroy Stat::AnimeCategoryBreakdown' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::AnimeCategoryBreakdown', user, :destroy, entry)
        subject.after_destroy
      end

      it 'queues a worker to destroy Stat::AnimeAmountConsumed' do
        expect(StatWorker).to receive(:perform_async)
          .with('Stat::AnimeAmountConsumed', user, :destroy, entry)
        subject.after_destroy
      end
    end
  end

  describe '.hook(klass)' do
    it 'calls after_update on the class, passing itself' do
      expect(LibraryEntry).to receive(:after_update).with(described_class)
      described_class.hook(LibraryEntry)
    end

    it 'calls after_create on the class, passing itself' do
      expect(LibraryEntry).to receive(:after_create).with(described_class)
      described_class.hook(LibraryEntry)
    end

    it 'calls after_destroy on the class, passing itself' do
      expect(LibraryEntry).to receive(:after_destroy).with(described_class)
      described_class.hook(LibraryEntry)
    end
  end
end
