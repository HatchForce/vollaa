require 'rubygems'
require 'mechanize'

@timestamp = Time.now.strftime("%Y%m%d%H%M%S")

def get_properties(place, state)
  agent = Mechanize.new
  @url = "http://propertyfeast.com/"
  @place = place
  @state = state
  main_page = agent.get(@url)
  form = main_page.form_with(:class => 'formtastic search')
  form.field_with(:name => 'location').value = place
  search_page = agent.submit(form)
  page = search_page
  parsing(page, 1)
  #------Pagination start-------#
  paging = search_page.parser.xpath("//span[@class='next']")
  p = 2
  result = paging(paging,p)
  while true
      p = p + 1
      paging = result.parser.xpath("//span[@class='next']")
      result = paging(paging,p) rescue break
  end
  #------Pagination Ends-------#
end

def paging(paging, p)
  next_page = Mechanize.new.get(@url + paging.children()[1].attribute('href'))
  parsing(next_page, p)
  return next_page
end

def parsing(page, p)
  @data_container = []
  li = page.parser.xpath("//li[@class='listing']")
  x = (0..li.size-1)
  x.each do |x|
    puts "####{@place}_#{p}_#{x}###"
    property_for = "sale"
    city = @place
    state = @state
    country = "India"
    more_link = "http://propertyfeast.com" + li[x].children().children()[0].children()[0].attribute('href') rescue ""
    property_title = li[x].children().children()[0].children()[0].children()[1].attribute('alt') rescue ""
    property_image = li[x].children().children()[0].children()[0].children()[1].attribute('src') rescue ""
    property_description = li[x].children().children()[1].children()[0].children().children()[6].text.strip().split("\n").join().to_s rescue ""
    link_page = Mechanize.new.get(more_link) rescue ""
    link_class = link_page.parser.xpath("//div[@class='general-features']").children() rescue ""
    property_type = link_class.children()[2].children() rescue ""
    p_price = li[x].children().children()[1].children()[0].children().children()[7].children().to_s.split("s. ")[1] rescue ""
    if p_price == nil
      p_price = li[x].children().children()[1].children()[0].children().children()[9].children().to_s.split("s. ")[1] rescue "0"
    end
    if p_price.match("lakh")
      property_price = (p_price.to_f * 100000).to_i rescue ""
    elsif p_price.match("crore")
      property_price = (p_price.to_f * 10000000).to_i rescue ""
    else
      property_price = 0
    end
    created_at = Time.now
    source = "propertyfeast.com"
    property_age = ""
    last_update = ""
    b_u_area = link_page.parser.xpath("//div[@class='property-size']").children().children()[2].children().to_s rescue ""
    if b_u_area.match("Ft")
      built_up_area = b_u_area.split("Sq")[0].strip().split(",").join().to_i / 9 rescue ""
    else
      built_up_area = b_u_area
    end
    bedrooms = link_class.children()[5].children().to_s.to_i rescue ""
    @data_container << [property_type, property_for, city, state, country, property_title, property_description, property_price, built_up_area, bedrooms, property_age, last_update, property_image, source, more_link, created_at]
  end
  File.open("propertyfeast_#{@place}_#{@timestamp}.txt", 'a+') do |f|
    @data_container.each do|data|
      #puts data
      f.puts data.join("|")
    end
  end
  #------Download Html start-------#
  #File.open(file = "prop_feast_hyd_#{p}_#{@timestamp}.html", 'a+') do |t|
  #  t.puts page.body
  #  puts "#{page}_#{p}"
  #end
  #------Download Html End-------#
end

get_properties("Hyderabad", "Andhra Pradesh")
