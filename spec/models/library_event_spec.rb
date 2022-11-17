require 'rails_helper'

RSpec.describe LibraryEvent, type: :model do
  subject { described_class.new }

  it { is_expected.to belong_to(:library_entry).required }
  it { is_expected.to belong_to(:user).required }

  it { is_expected.to validate_presence_of(:kind) }

  it {
    expect(subject).to define_enum_for(:kind).with_values(%i[progressed updated reacted rated
                                                             annotated])
  }
end
