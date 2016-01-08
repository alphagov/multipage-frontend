atom_feed(root_url: @presenter.web_url, id: @presenter.web_url) do |feed|
  feed.title("Travel Advice Summary")
  feed.updated @presenter.public_updated_at
  feed.author do |author|
    author.name "GOV.UK"
  end
  render partial: "country", object: @presenter, locals: { feed: feed }
end
