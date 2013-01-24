require "rubygems"
require "mechanize"
require 'date'

@timestamp = Time.now.strftime("%Y%m%d%H%M%S")

def get_properties(i)
  agent = Mechanize.new
  page = agent.get("http://hyderabad.olx.in/real-estate-cat-16-p-#{i}")
  @data_container = []
  div_ar = page.parser.xpath("//*[@class='li odd row clearfix'] |// //*[@class='li even row clearfix'] |// //*[@class='li first row clearfix']")
  x = (0 .. (div_ar.size - 1)).to_a
  #x = [0,1,2]
  x.each do |x|
    puts "####"+" "+"#{i}" +"_#{x}"+"####"
    div = div_ar[x] rescue ""
    #city = div.children()[3].children()[5].children()[1].children()[0].text.split("-").last
    city = "Hyderabad"
    country = "India"
    state = "Andhra Pradesh"
    property_for = "sale"
    property_type = div.children()[3].children()[5].children()[1].children()[0].text.split("-")[0] rescue ""
    property_title = div.children()[3].children()[1].children()[1].children()[0].to_s.strip rescue ""
    property_description = property_title
    p_price = div.children()[5].children()[0].text rescue ""
    property_price = p_price.to_s.scan(/[\d]/).join().to_i / 100
    more_link = div.children()[3].children()[1].children()[1].attribute('href').to_s.strip rescue ""
    bedrooms = div.children()[3].children()[3].children()[1].children()[0].text.split(":")[1].to_s.strip rescue ""
    b_u_area = div.children()[3].children()[3].children()[5].text.split(":")[1] rescue ""
    built_up_area = b_u_area.to_s.scan(/[\d]/).join().to_i
    property_image = div.children()[1].children()[1].children()[1].children()[1].attribute('src') rescue ""
    source = "olx.co.in"
    created_at = Time.now
    property_age = ''
    l_update = div.children()[7].children()[0].to_s.strip
    if l_update.match("Today")
      last_update = Date.today
    elsif l_update.match("Yesterday")
      last_update = Date.today-1
    else
      last_update = Date.parse(l_update)
    end
    @data_container << [property_type, property_for, city, state, country, property_title, property_description, property_price, built_up_area, bedrooms, property_age, last_update, property_image, source, more_link,created_at]
  end
  File.open(file = "olx_hyderabad_#{@timestamp}.txt", 'a+') do |t|
    @data_container.each do |data|
      #puts data
      t.puts data.join("|")
    end
  end
end

i = 1
until i == 201
  get_properties(i)
  i = i + 1
end