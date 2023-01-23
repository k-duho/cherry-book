class HttpRequest
  require 'open-uri'

  attr_reader :request_uri, :response

  def initialize(base_uri, params)
    @base_uri = base_uri
    @query_params = params.to_query
    @request_uri = URI.unescape(build_uri.force_encoding("UTF-8"))
  end

  def get_request
    puts "request to #{@request_uri}"
    @response = Net::HTTP.get_response(URI URI.encode @request_uri)
  end

  private

  def build_uri
    @base_uri + "?" + @query_params
  end
end

class HttpResponse
  attr_reader :parsed_body, :status

  def initialize(http_res)
    @parsed_body = JSON.parse(http_res.body)
  end

  def body_to_hash_items(necessary_keys, target_parent_keys)
    parsed_body.dig(*target_parent_keys).map do |item|
      item.slice(*necessary_keys)
    end
  end
end

Struct.new("RequestObj", :level, :page, :max_page, :result) do
  def generate_params
    {
      "level" => level,
      "page" => page
    }
  end

  def log(status, message = "")
    puts "#{status}: in #{level} page#{page}\n#{message} "
  end
end
