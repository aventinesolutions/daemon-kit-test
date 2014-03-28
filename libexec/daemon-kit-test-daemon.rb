require 'socket'
require 'sleep_interval_randomizer'

include SleepIntervalRandomizer

# Change this file to be a wrapper around your daemon code.

# Do your post daemonization configuration here
# At minimum you need just the first line (without the block), or a lot
# of strange things might start happening...
DaemonKit::Application.running! do |config|
  # Trap signals with blocks or procs
  # config.trap( 'INT' ) do
  #   # do something clever
  # end
  config.trap('TERM', Proc.new { puts 'Going down' })
end

SERVER = TCPServer.open(50000)
loop do
  Thread.start(SERVER.accept) do |client|
    safely do
      client.puts('Hello client')
      loop do
        client.puts(Time.now.ctime)
        sleep next_interval
      end
    end
  end
end
