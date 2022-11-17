class ImageDimensionsValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    return if value.blank?

    actual = dimensions_for(value)
    return unless actual

    height = options[:height]
    width = options[:width]
    aspect = options[:aspect_ratio]

    errors = [
      validate_value('height', actual.height, height),
      validate_value('width', actual.width, width),
      validate_value('aspect ratio', actual.aspect, aspect)
    ].compact
    errors.each do |error|
      record.errors.add(attr, error)
    end
  end

  def dimensions_for(attachment)
    return unless attachment.queued_for_write[:original]
    file = attachment.queued_for_write[:original].path
    Paperclip::Geometry.from_file(file)
  end

  def validate_value(name, value, target)
    return unless target
    return if target === value # rubocop:disable Style/CaseEquality

    if target.respond_to?(:begin) && target.respond_to?(:end)
      "#{name} must be between #{target.begin} and #{target.end}"
    else
      "#{name} must be #{target}"
    end
  end
end
