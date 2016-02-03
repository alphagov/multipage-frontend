GovukContentSchemaTestHelpers.configure do |config|
  config.schema_type = 'frontend'
  config.project_root = Rails.root
end

RSpec.configure do |config|
  config.include GovukContentSchemaTestHelpers
end
