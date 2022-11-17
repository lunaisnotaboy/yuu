class KitsuSchema < GraphQL::Schema
  default_max_page_size 2000

  mutation Types::MutationType
  query Types::QueryType

  tracer SentryTracing
  use GraphQL::Batch

  query_analyzer Analysis::MaxNodeLimit

  def self.resolve_type(_type, object, _context)
    "Types::#{object.class.name}".safe_constantize
  end
end
