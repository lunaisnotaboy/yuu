module RankedResource
  extend ActiveSupport::Concern

  included do
    class_attribute :_ranked_attributes
  end

  class_methods do
    def ranks(column_name)
      self._ranked_attributes ||= []
      self._ranked_attributes << column_name

      position_name = "#{column_name}_position"

      define_method(column_name) do
        case position = _model.public_send(position_name)
        when :first then 1
        when :up, :down then nil
        when Integer then position + 1
        else
          ranker = _model.class.ranker(column_name)
          fields = _model.attributes.slice(*ranker.with_same.map(&:to_s))
          siblings = _model.class.where(fields)
          siblings.where("#{column_name} < ?", _model.public_send(column_name)).count
        end
      end

      define_method("#{column_name}=") do |val|
        _model.public_send("#{position_name}=", val - 1)
      end
    end

    def find_records(filter, opts = {})
      return super unless _ranked_attributes

      attrs = _ranked_attributes.map do |column_name|
        ranker = _model_class.ranker(column_name)
        partition = ranker.with_same.join(', ')

        <<-SQL.squish
          (row_number() OVER (
            PARTITION BY #{partition}
            ORDER BY #{column_name} ASC
          ) - 1) AS #{column_name}_position
        SQL
      end
      attrs = attrs.join(', ')

      super.select("*, #{attrs}")
    end
  end
end
