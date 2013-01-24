require "rubygems"
require "mechanize"
@timestamp = Time.now.strftime("%Y%m%d%H%M%S")

def get_properties(i,p_for,f_for,p_type,f_type)
  agent = Mechanize.new
  url = "http://www.makaan.com"

  search_page = agent.get("#{url}/search-property")
  #----Search Page Start-----#
  form = search_page.form('searchFrm')
  form.budget_from = 100000
  form.budget_to = 1000000000
  form.city = "M6"
  #Ahmedabad-M7, Bangalore-M3, Chandigarh-M562, Chennai-M5, Delhi-M1,Hyderabad-M6,Kolkata-M4,Mumbai-M2,other-M8
  #AndhraPradesh-M9,Arunachal Pradesh-M10,Assam-M11,Bihar-M12,Chattisgarh-M13,Delhi-M4,Goa-M15,Gujarat-M16,Haryana - M17
  #Himachal Pradesh- M18, Jammu & Kashmir - M19, Jharkhand - M20, Karnataka -M21, Kerala - M22, Madhya Pradesh - M23, Maharashtra - M24

  form['property_type'] = f_type
  @property_type = p_type

  form['property_for'] = f_for
  @property_for = p_for
  #
  #form['property_type'] = 1
  #@property_type = "Residential"

  #form['property_type'] = 2
  #@property_type = "Commercial"

  #form['property_for'] = 1
  #@property_for = "sale"

  #form['property_for'] = 2
  #@property_for = "rent"

  @search_page = agent.submit(form) #first search results output submit and stores page
  page = @search_page
  p = 1
  parsing(page,p)
  #----Search Page End-----#

  #----Pagination Start-----#
  p = 2
  paging = page.parser.xpath("//span[@class='textnopad newpgclass']")
  result = paging(paging,p)
  while true
    if paging.last.attribute('class') == "textnopad newpgclassselect"
      break
    else
      p = p + 1
      break if (paging.last.children()[0].children()[0].to_s.scan(/[A-Za-z]/).join() != "Nextgt")
      paging = result.parser.xpath("//span[@class='textnopad newpgclass']")
      result = paging(paging,p)
    end
  end
  #----Pagination End-----#
end

def paging(paging, p)
  agent = Mechanize.new
  url = "http://www.makaan.com"
  next_page = agent.get(url + paging.last.elements.attribute('href'))
  parsing(next_page,p)
  return next_page
end


def parsing(page,p)
  @data_container = []
  #File.open(file = "../data/makaan/makaan_#{p}_#{@timestamp}.html", 'a+') do |t|
  #  t.puts page.body
  #  puts "#{page}_#{p}"
  #  break
  #end
  table = page.parser.xpath('//table[@class="ppsearch"]')
  x = [2,3,4,5,6,8,9,10,11,13,14,15,16,17,18,19,20,21,23,24,25,26]
  x.each do |x|
    puts "#### #{p}_#{x}_#{@property_type}_#{@property_for} ####"
    td = table[x].children()[1]  rescue ''
    data = td.children()[0].children()[0].children()[6].children()[1] rescue ''
    property_type = @property_type
    property_for = @property_for
    city = 'Hyderabad'
    @city = city
    state = 'Andhra Pradesh'
    country = 'India'
    title1 = data.children()[3].children()[1].text().to_s rescue ''
    title2 = data.children()[3].children()[3].text().to_s.split rescue ''
    property_title = "#{title1}, #{title2.join(" ") rescue ""}"
    property_description = data.children()[3].children()[11].children()[1].children()[0].to_s rescue ''
    p_p = data.children()[3].children()[5].text() rescue ''
    p_pr = p_p.split('.')[1].split('/')[0].split(',') rescue ''
    property_price = p_pr.join().to_i  rescue ''
    area = data.children()[3].children()[7].children()[1] rescue ""
    b_area = area.children()[2].children()[0].to_s rescue '0'
    if b_area.match("Ft")
      built_up_area = (b_area.scan(/[\d]/).join().to_i / 9)
    elsif b_area.match("Yd")
      built_up_area = (b_area.scan(/[\d]/).join().to_i)
    else
      built_up_area = 0
    end
    bedrooms = area.children()[0].children()[0].to_s.scan(/[\d]/).join().to_i rescue 0
    property_age = b.split('|')[3] rescue ''
    image = data.children()[5].children()[5].children()[1].elements[0] rescue ''
    property_image = image.children()[0].attribute('src') rescue ''
    last_update = Date.parse(data.children()[5].children()[1].text()) rescue ''
    more_link = data.children()[3].children()[1].children().attribute('href')  rescue ''
    source = "makaan.com"
    created_at = Time.now
    @data_container << [property_type,property_for,city,state,country,property_title,property_description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,source,more_link, created_at]
  end
  File.open("makaan_hyderabad_#{@timestamp}.txt", 'a+') do |f|
    @data_container.each do|data|
      #puts data
      f.puts data.join("|")
    end
  end
end

def prop(p)
  i = 0
  get_properties(i,p_for = "sale",f_for = 1,p_type = "Residential",f_type = 1)
  get_properties(i,p_for = "rent",f_for = 2,p_type = "Residential",f_type = 1)
  get_properties(i,p_for = "sale",f_for = 1,p_type = "Commercial",f_type = 2)
  get_properties(i,p_for = "rent",f_for = 2,p_type = "Commercial",f_type = 2)
end

p = 0
prop(p)
