class Property < ActiveRecord::Base
  attr_accessible :property_type, :property_for, :city, :state, :country, :property_title, :property_description, :property_price, :built_up_area, :bedrooms, :property_age, :last_update, :property_image, :source, :more_link

  scope :bedrooms, lambda { where(:bedrooms => 1) }
  scope :price, where("property_price >= ?", 10000000) #property_price more than 1cr
  scope :area, where("built_up_area >= ?", 4000) #land area with more than 4000 sft
  scope :city, where(:city => "ahmedabad")
  scope :state, where(:state => "Gujarath")

  searchable do
    text :city, :property_title
    string :property_type
    string :property_for
    string :property_title, :stored => true
    string :property_description, :stored => true
    integer :bedrooms
    integer :property_price, :trie => true
    integer :built_up_area
    string :city
    string :state
    string :built_up_area
    string :source
    Date :created_at

    string :sort_title do
      property_for.downcase.gsub(/^(an?|the)\b/, '')
    end
  end

end
