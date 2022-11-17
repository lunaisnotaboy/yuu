class MediaProduction < ApplicationRecord
  enum role: { producer: 0, licensor: 1, studio: 2, serialization: 3 }

  belongs_to :media, polymorphic: true, inverse_of: :productions
  belongs_to :company, class_name: 'Producer'

  def rails_admin_label
    company.name
  end
end
