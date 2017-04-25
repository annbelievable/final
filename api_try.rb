
#how to get response from api
#tried with Chuck Norris API


# require 'open-uri'
# response = open('https://api.chucknorris.io/jokes/random').read

# require 'net/http'
# result = Net::HTTP.get(URI.parse('https://api.chucknorris.io/jokes/random'))

# require "net/http"
# require "uri"
# uri = URI.parse("https://api.chucknorris.io/jokes/random")
# response = Net::HTTP.get_response(uri)

#this one is weird though
# require 'net/http'
# url = URI.parse('https://api.chucknorris.io/jokes/random')
# req = Net::HTTP::Get.new(url.to_s)
# res = Net::HTTP.start(url.host, url.port) {|http|
#   http.request(req)
# }

#this work best because of the last sentence, which means previous ones works too, however requires JSON parsing
#used this one but i make it short
require 'net/http'
require 'json'
url = 'https://api.chucknorris.io/jokes/random'
uri = URI(url)
response = Net::HTTP.get(uri)
JSON.parse(response)
