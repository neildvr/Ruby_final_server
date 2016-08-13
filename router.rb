require './controller/home_controller.rb'
require './routes.rb'
require './request.rb'

class Routing
  attr_reader :request
  def initialize(session)
    @request = Request.new(session)
    @routes  = Routes.get
  end

  def get_response
    response = "<h1> 404 not found! </h1>"
    @routes.each do |route|
      if route.exist? @request.method, @request.path
        #response = @request.method == 'GET' ? route.action.call : route.action.call(@request.params)
        response = route.action.call(@request.params,@request.path)
        break
      end
    end
    return response
  end
end

class Rout
  attr_reader :action
  def initialize(method, path, action)
    @method = method
    @path   = path
    @action = action
  end

  def exist?(method, path)
    if @path.class == Regexp
      @method == method && @path =~ path
    else
      @method == method && @path == path
    end
  end
end