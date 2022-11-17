module Analysis
  class MaxNodeLimit
    class ConnectionScopeType < BaseScopeType
      def total_nodes(child_nodes_amount)
        (argument_value * child_nodes_amount) + argument_value
      end

      def valid?
        if node_argument.nil?
          message = "Connection '#{field_definition.name}' requires the argument 'first' or 'last' to be supplied."

          raise GraphQL::AnalysisError.new(message, ast_node: @node)
        elsif !argument_value.between?(1, 2000)
          message = "Connection '#{field_definition.name}' argument '#{node_argument.name}' must be between 1 - 2000."

          raise GraphQL::AnalysisError.new(message, ast_node: @node)
        end

        true
      end

      private

      # The value is stored differently depending if they use a variable or not
      def argument_value
        query.variables
      end

      def node_argument
        @node_argument ||= @node.arguments.find { |arg| %w[first last].include?(arg.name) }
      end
    end
  end
end
