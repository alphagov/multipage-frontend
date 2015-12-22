require "gds_api/content_store"

module ContentStore

  def self.service
    @service ||= GdsApi::ContentStore.new(content_store_url)
  end

private

  def self.content_store_url
    Plek.find(content_store_name)
  end

  def self.content_store_name
    ENV["DRAFT_CONTENT_STORE"] ? "draft-content-store" : "content-store"
  end
end

# Initialize the service
ContentStore.service
