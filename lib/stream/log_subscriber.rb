module Stream
  class LogSubscriber < ActiveSupport::LogSubscriber
    def follow(event)
      return unless logger.debug?

      payload = event.payload
      name = format_name('Follow', event.duration, CYAN)

      debug "  #{name}  #{format_follows(payload[:source], payload[:target])}"
    end

    private

    def format_feed(feed)
      ::Feed.get_stream_id(feed)
    end

    def format_follows(*follows)
      follows = follows.flatten

      follows.flat_map do |follow|
        follow.map { |source, target| "#{format_feed(source)} -> #{format_feed(target)}" }
      end.join(', ')
    end

    def format_name(name, duration, color)
      self.color("#{name} (#{duration.round(1)}ms)", color, true)
    end
  end
end
