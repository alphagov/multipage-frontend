require "gds_api/content_store"

MultipageFrontend.content_store = GdsApi::ContentStore.new(Plek.find("content-store"))
