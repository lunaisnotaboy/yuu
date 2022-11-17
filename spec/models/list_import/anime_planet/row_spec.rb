require 'rails_helper'

RSpec.describe ListImport::AnimePlanet::Row do
  let(:anime) { fixture('list_import/anime_planet/toy-anime.html') }
  let(:manga) { fixture('list_import/anime_planet/toy-manga.html') }

  context 'Anime' do
    subject do
      described_class.new(
        Nokogiri::HTML(anime).css('.cardDeck .card').first,
        'anime'
      )
    end

    describe '#media' do
      it 'works for lookup' do
        expect(Mapping).to receive(:lookup)
          .with('animeplanet', 'anime/2353')
          .and_return('hello')

        subject.media
      end

      it 'works for guess' do
        allow(Mapping).to receive(:lookup).and_return(nil)
        args = {
          id: 2353,
          title: '07-Ghost',
          subtype: 'TV',
          episode_count: 25
        }
        expect(Mapping).to receive(:guess).with(Anime, args).and_return('hello')

        subject.media
      end
    end

    describe '#media_info' do
      it 'returns the id' do
        expect(subject.media_info[:id]).to eq(2353)
      end

      it 'returns the title' do
        expect(subject.media_info[:title]).to eq('07-Ghost')
      end

      it 'returns subtype' do
        expect(subject.media_info[:subtype]).to eq('TV')
      end

      it 'returns total episodes' do
        expect(subject.media_info[:episode_count]).to eq(25)
      end

      it 'does not return total amount of chapters' do
        expect(subject.media_info[:chapter_count]).to be_nil
      end
    end

    describe '#status' do
      context 'of "Watched"' do
        it 'returns :completed' do
          expect(subject.status).to eq(:completed)
        end
      end

      context 'of "Watching"' do
        it 'returns :current' do
          subject = described_class.new(
            Nokogiri::HTML(anime).css('.cardDeck .card')[1],
            'anime'
          )

          expect(subject.status).to eq(:current)
        end
      end

      context 'of "Want to Watch"' do
        it 'returns :planned' do
          subject = described_class.new(
            Nokogiri::HTML(anime).css('.cardDeck .card')[2],
            'anime'
          )

          expect(subject.status).to eq(:planned)
        end
      end

      context 'of "Stalled"' do
        it 'returns :on_hold' do
          subject = described_class.new(
            Nokogiri::HTML(anime).css('.cardDeck .card')[3],
            'anime'
          )

          expect(subject.status).to eq(:on_hold)
        end
      end

      context 'of "Dropped"' do
        it 'returns :dropped' do
          subject = described_class.new(
            Nokogiri::HTML(anime).css('.cardDeck .card')[4],
            'anime'
          )

          expect(subject.status).to eq(:dropped)
        end
      end

      context 'of "Wont Watch"' do
        it 'is ignored' do
          subject = described_class.new(
            Nokogiri::HTML(anime).css('.cardDeck .card')[5],
            'anime'
          )

          expect(subject.status).to be_nil
        end
      end
    end

    describe '#progress' do
      context 'Watched' do
        it 'returns total episodes' do
          expect(subject.progress).to eq(25)
        end
      end

      context 'Watching' do
        it 'returns episodes watched' do
          subject = described_class.new(
            Nokogiri::HTML(anime).css('.cardDeck .card')[1],
            'anime'
          )
          expect(subject.progress).to eq(1)
        end
      end

      context 'Want to Watch' do
        it 'alwayses return 0 episodes' do
          subject = described_class.new(
            Nokogiri::HTML(anime).css('.cardDeck .card')[2],
            'anime'
          )
          expect(subject.progress).to eq(0)
        end
      end
    end

    describe '#volumes' do
      it 'does not exist' do
        expect(subject.volumes).to be_nil
      end
    end

    describe '#rating' do
      it 'returns number quadrupled to match our 20-point scale' do
        expect(subject.rating).to eq(20)
      end
    end

    describe '#reconsume_count' do
      it 'returns amount of times watched' do
        expect(subject.reconsume_count).to eq(1)
      end
    end
  end

  context 'Manga' do
    subject do
      described_class.new(
        Nokogiri::HTML(manga).css('.cardDeck .card').first,
        'manga'
      )
    end

    describe '#media' do
      it 'works for lookup' do
        expect(Mapping).to receive(:lookup)
          .with('animeplanet', 'manga/1854')
          .and_return('hello')

        subject.media
      end

      it 'works for guess' do
        allow(Mapping).to receive(:lookup).and_return(nil)
        args = {
          id: 1854,
          title: '1/2 Prince',
          chapter_count: 76
        }
        expect(Mapping).to receive(:guess).with(Manga, args).and_return('hello')

        subject.media
      end
    end

    describe '#media_info' do
      it 'returns the id' do
        expect(subject.media_info[:id]).to eq(1854)
      end

      it 'returns the title' do
        expect(subject.media_info[:title]).to eq('1/2 Prince')
      end

      it 'returns subtype' do
        expect(subject.media_info[:subtype]).to be_nil
      end

      it 'does not return total amount of episodes' do
        expect(subject.media_info[:episode_count]).to be_nil
      end

      context 'total chapters' do
        it 'returns an integer' do
          expect(subject.media_info[:chapter_count]).to eq(76)
        end

        it 'returns 0 if no chapters present' do
          subject = described_class.new(
            Nokogiri::HTML(manga).css('.cardDeck .card').last,
            'manga'
          )

          expect(subject.media_info[:chapter_count]).to eq(0)
        end
      end
    end

    describe '#status' do
      context 'of "Read"' do
        it 'returns :completed' do
          subject = described_class.new(
            Nokogiri::HTML(manga).css('.cardDeck .card')[3],
            'manga'
          )

          expect(subject.status).to eq(:completed)
        end
      end

      context 'of "Reading"' do
        it 'returns :current' do
          expect(subject.status).to eq(:current)
        end
      end

      context 'of "Want to Read"' do
        it 'returns :planned' do
          subject = described_class.new(
            Nokogiri::HTML(manga).css('.cardDeck .card')[1],
            'manga'
          )

          expect(subject.status).to eq(:planned)
        end
      end

      context 'of "Stalled"' do
        it 'returns :on_hold' do
          subject = described_class.new(
            Nokogiri::HTML(manga).css('.cardDeck .card')[2],
            'manga'
          )

          expect(subject.status).to eq(:on_hold)
        end
      end

      context 'of "Dropped"' do
        it 'returns :dropped' do
          subject = described_class.new(
            Nokogiri::HTML(manga).css('.cardDeck .card')[4],
            'manga'
          )

          expect(subject.status).to eq(:dropped)
        end
      end

      context 'of "Wont Read"' do
        it 'is ignored' do
          subject = described_class.new(
            Nokogiri::HTML(manga).css('.cardDeck .card')[5],
            'manga'
          )

          expect(subject.status).to be_nil
        end
      end
    end

    describe '#progress' do
      context 'Stored as Volumes' do
        it 'alwayses return 0' do
          expect(subject.progress).to eq(0)
        end
      end

      context 'Stored as Chapters' do
        context 'Read' do
          it 'returns all chapters' do
            subject = described_class.new(
              Nokogiri::HTML(manga).css('.cardDeck .card')[3],
              'manga'
            )
            expect(subject.progress).to eq(357)
          end
        end

        context 'Reading' do
          it 'returns chapters read' do
            subject = described_class.new(
              Nokogiri::HTML(manga).css('.cardDeck .card')[2],
              'manga'
            )
            expect(subject.progress).to eq(13)
          end
        end
      end
    end

    describe '#volumes' do
      context 'Read' do
        it 'returns all volumes' do
          subject = described_class.new(
            Nokogiri::HTML(manga).css('.cardDeck .card')[3],
            'manga'
          )

          expect(subject.volumes).to eq(37)
        end
      end

      context 'Reading' do
        it 'returns number of volumes read' do
          expect(subject.volumes).to eq(11)
        end
      end
    end

    describe '#rating' do
      it 'returns number quadrupled' do
        expect(subject.rating).to eq(10)
      end
    end

    describe '#reconsume_count' do
      it 'does not exist' do
        expect(subject.reconsume_count).to be_nil
      end
    end
  end
end
