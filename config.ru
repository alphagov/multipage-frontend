# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
require 'rack/gc_tracer'
require 'rack/allocation_tracer'

use Rack::GCTracerMiddleware, view_page_path: '/gc_tracer', filename: '/tmp/rails-gc_tracer'
use Rack::AllocationTracerMiddleware

run Rails.application
