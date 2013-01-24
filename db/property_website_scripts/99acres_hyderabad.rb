#As of 17 jan 2012
require "rubygems"
require "mechanize"
@timestamp = Time.now.strftime("%Y%m%d%H%M%S")

def get_properties(i)
  @data_container = []
  agent = Mechanize.new
  search_page = agent.get("http://www.99acres.com/do/quicksearch/")
  if i == 1
    #----Search Page Start-----#
    form = search_page.form('search_form')
    #puts form.city
    #puts form.field_with(:name => 'city').options[38].select
    form.field_with(:name => 'city').value = 38
    @search_page = agent.submit(form) #first search results output submit and stores page
    page = @search_page
    #----Search Page End-----#
  else
    #----Pagination Start-----#
    paging_form = @search_page.form_with(:name => "paging")
    paging_form['page'] = i
    @search_page = agent.submit(paging_form)
    page = @search_page
    #----Pagination End-----#
  end
  #------Parsing Start------#
  table_class = page.parser.xpath("//div[@class='sT ']")
  size = table_class.size
  x = (0 .. size).to_a
  x.each do |n|
    table = table_class[n]
    property_type = "Residential"
    property_for = "sale"
    city = "Hyderabad"
    state = "Andhra Pradesh"
    country = "India"
    property_title = table.children()[1].children()[7].children()[0] rescue ""
    property_description = table.children()[3].children()[3].children()[3].children()[0].text.strip().split("\r\n").join() rescue ""
    p_price = table.children()[1].children()[5].children()[0].to_s rescue ""
    if p_price.match("Crore")
      property_price = (p_price.to_f * 10000000).to_i
    elsif p_price.match("Lac")
      property_price = (p_price.to_f * 100000).to_i
    else
      property_price = 0
    end
    area = table.children()[3].children()[3].children()[1].children()[1].children()[0].to_s.to_i rescue ""
    built_up_area = area/9 rescue ''
    property_image = table.children()[3].children()[1].children()[1].children()[1].children()[1].attribute('src') rescue ""
    bedrooms = property_title.to_s[0].to_i rescue ""
    property_age = ""
    last_update = Date.parse(table.children()[5].children()[7].children()[0]) rescue ""
    more_link = "www.99acres.com" + table.children()[1].children()[7].attribute('href') rescue ""
    source = "99acres.com"
    created_at = Time.now

    @data_container << [property_type, property_for, city, state, country, property_title, property_description, property_price, built_up_area, bedrooms, property_age, last_update, property_image, source, more_link, created_at]
    puts "####"+" "+"#{i}_#{n}" +" "+"####"
  end
  File.open("99acres_Hyderabad_#{@timestamp}.csv", 'a+') do |f|
    @data_container.each do |data|
      #puts data
      f.puts data.join("|")
    end
  end
  #------Download Html start-------#
  #File.open(file = "99acres_hyd_#{i}_#{@timestamp}.html", 'a+') do |t|
  #  t.puts page.body
  #  puts "#{page}_#{i}"
  #  break
  #end
  #------Download Html End-------#
  #------Parsing End------#
end

i = 1
until i == 2
  get_properties(i)
  i = i + 1
end
