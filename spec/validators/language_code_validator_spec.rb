require 'rails_helper'

RSpec.describe LanguageCodeValidator do
  subject { described_class.new(attributes: %i[language]) }

  record_class = Struct.new(:language) do
    extend ActiveModel::Naming
    include ActiveModel::Validations
  end

  context 'with a single language code' do
    context 'on an invalid record' do
      let(:record) { record_class.new('**') }

      it 'adds an error' do
        subject.validate(record)
        expect(record.errors).to include(:language)
        expect(record.errors.count).to eq(1)
      end
    end

    context 'on a valid record' do
      let(:record) { record_class.new('en') }

      it 'has no errors' do
        subject.validate(record)
        expect(record.errors).to be_empty
      end
    end
  end

  context 'with a list of country codes' do
    context 'on a completely invalid list' do
      let(:record) { record_class.new(['**', '__', '&&']) }

      it 'adds an error for each invalid item' do
        subject.validate(record)
        expect(record.errors).to include(:language)
        expect(record.errors.count).to eq(3)
      end
    end

    context 'on a partially invalid list' do
      let(:record) { record_class.new(['en', '&&', 'fr', '__', 'ru']) }

      it 'adds an error for each invalid item' do
        subject.validate(record)
        expect(record.errors).to include(:language)
        expect(record.errors.count).to eq(2)
      end
    end

    context 'on a fully valid list' do
      let(:record) { record_class.new(%w[en fr es]) }

      it 'has no errors' do
        subject.validate(record)
        expect(record.errors).to be_empty
      end
    end
  end
end
