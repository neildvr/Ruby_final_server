require 'uri'
require 'socket'

str = <<-EOF
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>
	<form  action="test.rb" method="POST">
	  <table border="0" align="center">
	       <tr>
	     <td class="avto">Логин:
	     </td>
	     <td > <input type="text" name="login" size="30">
	     </td>
	     </tr>
	       <tr >
	     <td class="atvo">Пароль:
	     </td>
	     <td ><input type="text" name="pass" size="30">
	     </td>
	     </tr>
	       <tr>
	     <td colspan="2" align="center">
	       <input type="submit" value="Отправить">
	     <input type="reset" value="Очистить">
	     </td>
	     </tr>
		</table>
    <p><textarea rows="10" cols="45" name="text"></textarea></p>
	</form>
</body>
</html>
EOF

def run
  @port = 3030
  @server = TCPServer.new(@port)
  puts "Connecting on port #{@port}"

  loop do
    socket = @server.accept
    request = verb_and_header(socket)

    http_verb = request[:verb]
    request_uri = request[:request_uri]
    headers = request[:headers]

    if headers.has_key? 'Content-Length'
      http_body = body(socket, headers['Content-Length'].to_i)
      headers['Body'] = http_body
      STDERR.puts http_body
    end

    if http_verb == 'GET'
      get(request_uri, socket)
    elsif http_verb == 'POST'
      #post(request, socket)
    elsif http_verb == 'PUT'
      #put(request, socket)
    elsif http_verb == 'DELETE'
      #delete(request, socket)
    elsif http_verb == 'HEAD'
      #head(request, socket)
    end
  end
end

  def verb_and_header(socket)
    request = ""
    headers = {}
    while (request_line = socket.gets and request_line != "\r\n")
      request += request_line
    end

    header_params = request.split(/\r?\n/)
    first_line = header_params.shift.split(" ")
    verb = first_line[0]
    request_uri = first_line[1]
    header_params.each do |param|
      key_value = param.split(':')
      headers.merge!(key_value[0] => key_value[1].strip)
    end
    {:verb => verb, :request_uri => request_uri, :headers => headers}
  end



  def get(request_uri, socket)
    path = requested_file(request_uri)

    if File.directory?(path)
      path = File.join(path, 'index.html')
    end

    # Make sure the file exists and is not a directory
    # before attempting to open it.
    if File.exist?(path) && !File.directory?(path)
      File.open(path, "rb") do |file|
        socket.print "HTTP/1.1 200 OK\r\n" +
                         "Content-Type: #{content_type(file)}\r\n" +
                         "Content-Length: #{file.size}\r\n" +
                         "Connection: close\r\n"

        socket.print "\r\n"

        # write the contents of the file to the socket
        IO.copy_stream(file, socket)
      end
    else
      message = "File not found\n"

      # respond with a 404 error code to indicate the file does not exist
      socket.print "HTTP/1.1 404 Not Found\r\n" +
                       "Content-Type: text/plain\r\n" +
                       "Content-Length: #{message.size}\r\n" +
                       "Connection: close\r\n"

      socket.print "\r\n"

      socket.print message
    end
  end

  run