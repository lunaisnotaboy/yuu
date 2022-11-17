class HTMLFilters::EmbedFilter < HTML::Pipeline::Filter
  def call
    result[:embeddable_links] = doc.css('a.autolink, .onebox a').map { |a| a['href'] }
    doc
  end
end
