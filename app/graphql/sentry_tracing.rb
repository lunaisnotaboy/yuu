class SentryTracing
  def self.trace(key, data)
    if key.starts_with?('execute_query')
      # Set the transaction name base on the operation type and name
      selected_op = data[:query].selected_operation

      if selected_op
        op_type = selected_op.operation_type
        op_name = selected_op.name || 'anonymous'
      else
        op_type = 'query'
        op_name = 'anonymous'
      end

      begin
        Raven.context.transaction.push("GraphQL/#{op_type}.#{op_name}")

        yield
      ensure
        Raven.context.transaction.pop
      end
    else
      yield
    end
  end
end
