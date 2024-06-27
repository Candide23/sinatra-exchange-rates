require "sinatra"
require "sinatra/reloader"

require "http"


get("/") do

  @url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
 

  @raw_response = HTTP.get(@url)

  @raw_string = @raw_response.to_s

  @parsed_data = JSON.parse(@raw_string)

  @currencies =   @parsed_data.fetch("currencies")



 erb(:homePage)
end

get("/:from_currency") do

  @original_currency = params.fetch("from_currency")


  @url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY").chomp}"
 

  @raw_response = HTTP.get(@url)


  @raw_string = @raw_response.to_s

  @parsed_data = JSON.parse(@raw_string)

  @currencies = @parsed_data.fetch("currencies")

  erb(:step_one)

end
  
  

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  @url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  
  @raw_response = HTTP.get(@url)


  @raw_string = @raw_response.to_s

  @parsed_data = JSON.parse(@raw_string)

  @amount =  @parsed_data.fetch("result")

  erb(:step_two)
  # Some more code to parse the URL and render a view template.
end
