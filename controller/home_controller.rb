require './users.rb'
require './templates.rb'
#$params = nil

$index = ->(*params) {

  <<-EOF
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>admin panel</title>
</head>
<style>
	div {
		border: 1px solid black; /* Параметры рамки */
		padding: 5px; /* Поля вокруг текста */
		margin-bottom: 5px; /* Отступ снизу */
	}
	#center { text-align: center; }
	.content {
		width: 99%; /* Ширина слоя */
		background: #fc0; /* Цвет фона */
	}
</style>
<body>


<h1 id="center"> Добро пожаловать в блог </h1>



		<div id="center"><div class="content"><p>#{@db_blogs[0]}</p></div></div>
    <div id="center"><div class="content"><p>#{@db_blogs[1]}</p></div></div>
    <div id="center"><div class="content"><p>#{@db_blogs[2]}</p></div></div>
    <div id="center"><div class="content"><p>#{@db_blogs[3]}</p></div></div>
    <div id="center"><div class="content"><p>#{@db_blogs[4]}</p></div></div>

<div id="center" ><a href=/admin>Авторизироваться</a></div>



</body>
</html>
  EOF


}


@blog = <<-EOF
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>admin panel</title>
</head>
<style>
	div {
		border: 1px solid black; /* Параметры рамки */
		padding: 5px; /* Поля вокруг текста */
		margin-bottom: 5px; /* Отступ снизу */
	}
	#center { text-align: center; }
	.content {
		width: 99%; /* Ширина слоя */
		background: #fc0; /* Цвет фона */
	}
</style>
<body>

<h1 id="center"> Вы авторизованы! </h1>
<h1 id="center"> Добро пожаловать в блог </h1>

		<div id="center"><div class="content"><p>#{@db_blogs[0]}   <a href="delete/0">Delete</a></p></div></div>
    <div id="center"><div class="content"><p>#{@db_blogs[1]}   <a href="delete/1">Delete</a></p></div></div>
    <div id="center"><div class="content"><p>#{@db_blogs[2]}   <a href="delete/3">Delete</a></p></div></div>
    <div id="center"><div class="content"><p>#{@db_blogs[3]}   <a href="delete/4">Delete</a></p></div></div>
    <div id="center"><div class="content"><p>#{@db_blogs[4]}   <a href="delete/5">Delete</a></p></div></div>





</body>
</html>
EOF

$auth_form = ->(*params) {
  unless @authorized
   File.read('./views/form.html')
  else
   $admin_page.call
  end
  }

$admin_page = ->(*params) {
  if @authorized
    @blog
  else
    "<h2> Need authorize!!! </h2>"
    #$auth_form.call
  end
}

$authenticate = -> (*params) {
  if @db_user == params[0]
    @authorized = true
    $admin_page.call
  else
    "error login or password"
    #$auth_form.call
  end
}

$show = -> (*params) {
  blog_id = params[1].split("/").last.to_i
  #Здесь должен быть шаблон
  str = "<h1>good show!!!!!!!!</h1>" +
        "<h2> Blog number \##{blog_id}"+
        "<h2> rst\##{@db_blogs[blog_id]}"
}

C300 = lambda {|code: 301, url: '/'| <<-EOF
HTTP/1.1 #{code} OK
Location: #{url}
Content-Type: text/html; charset=UTF-8
Connection: close

EOF
}

$delete = -> (*params) {
  blog_id = params[1].split("/").last.to_i
  @db_blogs.delete_at(blog_id)
  C300.call url: "/"
  puts blog_id

}

