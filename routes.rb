require './router.rb'
require './controller/home_controller.rb'
class Routes
  def self.get
    [
        Rout.new('GET' , '/'           , $index),
        Rout.new('GET' , /\/blog\/\d+/ , $show), #показать опреленный пост
        Rout.new('GET' , '/admin'      , $auth_form),
        Rout.new('POST', '/admin'      , $authenticate),
        Rout.new('GET' , '/admin/blogs', $admin_page), #список постов
        Rout.new('GET',  /\/delete\/\d+/, $delete)
    ]
  end
end
