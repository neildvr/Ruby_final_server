class Request
  attr_reader :method, :path, :params
  def initialize(session)
    params  = {}
    headers = {}
    request = {}
    while line = session.gets.to_s
      break if line == "\r\n"
      request[:method], request[:path] = line.split(' ') if line.include? ' HTTP'
      if line.include? ': '
        key, value = line.split ': '
        headers[key] = value
      end
    end
    body = session.read headers['Content-Length'].to_i
    parsed_body = body.split "&"
    parsed_body.each do |element|
      key,value = element.split "="
      params[key] = value
    end
    @params = params
    @method = request[:method]
    @path   = request[:path]
  end
end