require './blogs.rb'
list = '<ul>'
@list_blogs.each {|blog| list += "<li> #{blog.title} </li>"}
list += '</ul>'


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
    <a href="delete/3">Delete</a>

    #{@db_blogs}


</body>
</html>
EOF