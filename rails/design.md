## Request / Response
- 결국엔 문자열이다.

### Rails에서 Request의 흐름
Request -> Webserver -> Rack -> Middleware -> Router -> Controller -> View

### Smallest Webserver
```rb
require "socket"

port = 3000
server = TCPServer.open port

socket = server.accept

loop do
  line = socket.readline.chomp
  puts "Read: #{line}"

  if line.bytesize == 0
    socket.write "HTTP/1.1 200 OK \r\n"
    socket.write "\r\n"
    socket.write "Hello World\r\n"
    socket.close
    break
  end
end


=> ruby server.rb

$curl localhost:3000/hello
=>Read: GET /hello HTTP/1.1
Read: Host: localhost:3000
Read: User-Agent: curl/7.77.0
Read: Accept: */*
Read:
```

### 헤더를 포함하는 웹서버 예시
TODO

<br>

---

## Rack
TODO

<br>

---

## Middleware
TODO

<br>

---


