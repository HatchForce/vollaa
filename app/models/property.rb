class Property < ActiveRecord::Base
  attr_accessible :property_type, :property_for, :city, :state, :country, :property_title, :property_description, :property_price, :built_up_area, :bedrooms, :property_age, :last_update, :property_image, :source, :more_link
  has_one :property_map

  scope :bedrooms, lambda { where(:bedrooms => 1) }
  scope :price, where("property_price >= ?", 10000000) #property_price more than 1cr
  scope :area, where("built_up_area >= ?", 4000) #land area with more than 4000 sft
  scope :city, where(:city => "ahmedabad")
  scope :state, where(:state => "Gujarath")

  searchable do

    #autosuggest :property_property_title, :using => :property_title
    #autocomplete :property_property_desc, :using => :property_description

    text :city, :property_title, :boost => 9
    string :property_type
    string :property_for
    string :property_title, :stored => true
    string :property_description, :stored => true
    integer :bedrooms
    integer :property_price, :trie => true #, :boost => 5
    integer :built_up_area
    string :city
    string :state
    string :built_up_area
    string :source
    Date :created_at

  end

end
