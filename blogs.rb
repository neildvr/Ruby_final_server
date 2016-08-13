class Blog
  attr_accessor :title, :description
  def initialize(title,description)
    @title = title
    @description = description
  end
end

@list_blogs = [
  Blog.new('Super theme', 'Description blog ...')
]