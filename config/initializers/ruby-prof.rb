require "ruby-prof"

RubyProf.measure_mode = RubyProf::MEMORY

module Rack
  class RubyProf
    def call(env)
      request = Rack::Request.new(env)

      if @skip_paths.any? {|skip_path| skip_path =~ request.path}
        @app.call(env)
      else
        result = nil
        data = ::RubyProf::Profile.profile do
          result = @app.call(env)
        end

        path = request.path.gsub('/', '-')
        path.slice!(0)
        path = "#{Time.zone.now.to_i}-#{path}"

        print(data, path)
        result
      end
    end
  end
end
