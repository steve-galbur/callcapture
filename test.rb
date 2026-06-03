require "net/http"
require "uri"

URL = "https://example.com"
TOTAL_REQUESTS = 300
CONCURRENCY = 20

queue = Queue.new
TOTAL_REQUESTS.times { |i| queue << i + 1 }

threads = CONCURRENCY.times.map do
  Thread.new do
    while !queue.empty?
      begin
        i = queue.pop(true)
      rescue ThreadError
        break
      end

      uri = URI(URL)
      response = Net::HTTP.get_response(uri)

      puts "Request #{i}: #{response.code}"
    end
  end
end

threads.each(&:join)