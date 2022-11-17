module Analysis
  class MaxNodeLimit
    class BaseScopeType
      attr_reader :field_definition, :query

      delegate :complexity, to: :field_definition

      # A single Proc for {#scoped_children} hashes. Use this to avoid repeated
      # allocations, since the lexical binding isn't important.
      HASH_CHILDREN = ->(h, k) { h[k] = {} }

      # @param [GraphQL::Query] query Used for `query.possible_types`
      # @param [Language::Nodes::Field] node The AST node; used for providing
      #   argument values when necessary
      # @param [GraphQL::Field, GraphQL::Schema::Field] field_definition Used for
      #   getting the `.complexity` configuration
      def initialize(query, node: nil, field_definition: nil)
        @query = query
        @node = node
        @field_definition = field_definition
        @scoped_children = nil
      end

      # This value is only calculate when asked for to avoid needlesss hash
      # allocations. Also, if it's never asked for, we determine that this scope
      # complexity is a scalar field ({#terminal?}).
      #
      # @return [Hash<Hash<Class => ScopedTypeComplexity>>]
      def scoped_children
        @scoped_children ||= Hash.new(&HASH_CHILDREN)
      end

      # Returns true if this field has no selection, i.e. it's a scalar. We need
      # a quick way to check whether we should continue traversing.
      def terminal?
        @scoped_children.nil?
      end

      def valid?
        true
      end
    end
  end
end
