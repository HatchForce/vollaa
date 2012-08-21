class Property < ActiveRecord::Base
  attr_accessible :property_type,:property_for,:city,:state,:country,:property_title,:property_description,:property_price,:built_up_area,:bedrooms,:property_age,:last_update,:property_image,:source,:more_link


  searchable do
    text  :city, :property_title
    string :property_type
    integer :bedrooms
    integer :property_price, :trie => true

  end
end
