require 'rails_helper'

RSpec.shared_examples 'streamable' do
  # Columns which are mandatory for all streamables
  it { is_expected.to have_db_column(:regions).of_type(:string) }
  it { is_expected.to have_db_column(:dubs).of_type(:string) }
  it { is_expected.to have_db_column(:subs).of_type(:string) }

  it { is_expected.to belong_to(:streamer).required }

  it { is_expected.to validate_presence_of(:streamer) }
  it { is_expected.to validate_presence_of(:dubs) }

  it { is_expected.to respond_to(:available_in?) }

  let(:factory_type) { described_class.name.underscore.to_sym }

  describe '.available_in(region)' do
    it "filters to only include #{described_class} records available in the provided region" do
      create_list(factory_type, 2, regions: %w[US])
      expect(described_class.available_in('NL').count).to equal(0)
      expect(described_class.available_in('US').count).to equal(2)
    end
  end

  describe '#available_in?(region)' do
    it "returns false if the #{described_class} record is not available in the specified region" do
      record = create(factory_type, regions: %w[US])
      expect(record).not_to be_available_in('NL')
    end

    it "returns true if the #{described_class} record is available in the specified region" do
      record = build(factory_type, regions: %w[US])
      expect(record).to be_available_in('US')
    end
  end

  describe '.dubbed(langs)' do
    it "filters to only include #{described_class} records available in the provided dubs" do
      create_list(factory_type, 2, dubs: %w[en])
      expect(described_class.dubbed(%w[en]).count).to equal(2)
      expect(described_class.dubbed(%w[jp]).count).to equal(0)
    end
  end

  describe '.subbed(langs)' do
    it "filters to only include #{described_class} records available in the provided subs" do
      create_list(factory_type, 2, subs: %w[en])
      expect(described_class.subbed(%w[en]).count).to equal(2)
      expect(described_class.subbed(%w[jp]).count).to equal(0)
    end
  end
end
