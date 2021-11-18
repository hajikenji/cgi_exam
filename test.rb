require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/goyaa.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
# 追記
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'loot.html.erb')
server.mount('/goyab.cgi', WEBrick::HTTPServlet::CGIHandler, 'goyab.rb')
server.mount('/goyac.cgi', WEBrick::HTTPServlet::CGIHandler, 'goyac.rb')
server.start