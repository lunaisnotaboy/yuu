require 'rails_helper'
require 'dirty_change_wrapper'

RSpec.describe DirtyChangeWrapper do
  subject { DirtyChangeWrapper.new(base, changes) }

  let(:base) { OpenStruct.new(foo: 'bar') }
  let(:changes) { { baz: %w[bar bat] } }

  context 'for changes' do
    it 'provides a _was method to access the previous value' do
      expect(subject).to respond_to(:baz_was)
      expect(subject.baz_was).to eq('bar')
    end

    it 'provides a method to access the current value' do
      expect(subject).to respond_to(:baz)
      expect(subject.baz).to eq('bat')
    end

    it 'provides a _changed? method which returns true' do
      expect(subject).to respond_to(:baz_changed?)
      expect(subject.baz_changed?).to be_truthy
    end

    it 'provides a _change method to expose the raw change array' do
      expect(subject).to respond_to(:baz_change)
      expect(subject.baz_change).to eq(%w[bar bat])
    end
  end

  context 'for unchanged properties' do
    it 'provides a _was method which returns the current value' do
      expect(subject).to respond_to(:foo_was)
      expect(subject.foo_was).to eq('bar')
    end
  end

  context 'for missing properties' do
    it 'provides a _changed? method which returns false' do
      expect(subject).to respond_to(:nope_changed?)
      expect(subject.nope_changed?).to be_falsey
    end

    it 'provides a _change method which returns nil' do
      expect(subject).to respond_to(:nope_change)
      expect(subject.nope_change).to be_nil
    end
  end

  context 'for the base' do
    it 'delegates any methods it does not know' do
      expect(subject).to respond_to(:foo)
      expect(subject.foo).to eq('bar')
    end
  end
end
