class ProducerResource < BaseResource
  attributes :slug, :name

  filter :slug

  has_many :anime_productions
  has_many :productions
end
