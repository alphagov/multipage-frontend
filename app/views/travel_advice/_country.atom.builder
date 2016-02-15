feed.entry(country, id: "#{country.web_url}##{country.public_updated_at}", url: country.web_url, updated: country.public_updated_at) do |entry|
  entry.title(country.title)
  entry.link(:rel => "self", :type => "application/atom+xml", :href => "#{country.web_url}.atom")
  entry.summary(:type => :xhtml) do |summary|
    summary << country.atom_change_description
  end
end
