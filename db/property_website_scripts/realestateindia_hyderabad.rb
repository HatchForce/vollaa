require 'rubygems'
require 'mechanize'

@timestamp = Time.now.strftime("%Y%m%d%H%M%S")

def get_properties(f_for,f_type,f_city,place, state)
  agent = Mechanize.new
  @url = "http://www.realestateindia.com/"
  @place = place
  @state = state
  main_page = agent.get(@url)
  form = main_page.form_with(:name => 'leftsearch')
  form.radiobutton_with(:value => f_for).check #sale
  form.field_with(:name => 'allcategory').value = f_type #Residential
  form.field_with(:name => 'allcity').value = f_city #Hyderabad
  search_page = agent.submit(form)
  page = search_page
  parsing(page, p=1)
  #------Pagination start-------#
  paging = search_page.parser.xpath("//p[@class='fr b p5px paging']")
  result = paging(paging,p=2)
  while true
    p = p + 1
    paging = result.parser.xpath("//p[@class='fr b p5px paging']")
    result = paging(paging,p) rescue break
  end
  #------Pagination Ends-------#
end

def paging(paging, p)
  next_page = Mechanize.new.get(@url + paging.last.elements.last.attribute('href'))
  parsing(next_page, p)
  return next_page
end

def parsing(page, p)
  @data_container = []
  div = page.parser.xpath("//div[@class='classified_box p10px']")
  td = page.parser.xpath("//td[@class='lh14em pl10px pr5px small fft']")
  div_size = div.size
  (div_size == td.size)? x = (0 .. div_size - 1) : x = []
  #x = [1]
  x.each do |x|
    td_x = td[x]
    div_x = div[x]
    title = div_x.children()[1].children()[1].children()[0] rescue ""
    property_title = title.children()[0].children()[0] rescue ""
    more_link = title.attribute('href') rescue ""
    city = @place
    state = @state
    country = "India"
    property_type = "Residential"
    property_for = "sale"
    property_description = td_x.children().children()[0].to_s.strip().split("\r\n").join() rescue ""
    property_price = td_x.children()[3].children()[4].children()[4].children().to_s.split(",").join().split(" ")[1].to_i rescue ""
    a_b = td_x.children()[3].children()[1].children()[4].children().to_s.split(",") rescue ""
    b_u_area = a_b[0].split(":")[1] rescue ""
    if b_u_area.match("Feet")
      built_up_area = b_u_area.strip().split("Sq.")[0].to_i / 9
    elsif b_u_area.match("Yard")
      built_up_area = b_u_area.strip().split("Sq.")[0].to_i
    else
      built_up_area = ""
    end
    bedrooms = a_b[1].split(":")[1].strip() rescue ""
    property_age = ""
    last_update = ""
    property_image = div_x.children()[5].children()[6].children().children()[6].children().children()[0].attribute('src') rescue ""
    source = "realestateindia.com"
    created_at = Time.now
    puts "####{@place}_#{p}_#{x}###"
    puts property_description
    @data_container << [property_type, property_for, city, state, country, property_title, property_description, property_price, built_up_area, bedrooms, property_age, last_update, property_image, source, more_link, created_at]
  end
  File.open("realestateindia_hyderabad_#{@timestamp}.txt", 'a+') do |f|
    @data_container.each do|data|
      #puts data
      f.puts data.join("|")
    end
  end
  #------Download Html start-------#
  #File.open(file = "realestateindia_hyd_#{p}_#{@timestamp}.html", 'a+') do |t|
  #  t.puts page.body
  #  puts "#{page}_#{p}"
  #end
  #------Download Html End-------#
end

get_properties(f_for = "sell",f_type = 5, f_city = 77,"Hyderabad", "Andhra Pradesh")
