namespace :db do
  namespace :load do
    desc "Load Properties into DB"
    task :properties => :environment do
      Mysql2::Client.default_query_options[:connect_flags] |= Mysql2::Client::LOCAL_FILES
      Mysql2::Client.new(:username=>'root', :host=>'localhost', :password=>'', :database=>'vollaa_development', :local_infile => true)

      @files = Dir.entries("db/properties_data")
      connection = ActiveRecord::Base.connection()

      for file in @files
        next if file == "." || file == ".."
        sql = ["LOAD DATA LOCAL INFILE '#{Rails.root}/db/properties_data/#{file}'"]
        sql = ["INTO TABLE properties"]
        sql = ["FIELDS TERMINATED BY '|'"]
        sql = ["LINES TERMINATED BY '\r\n'"]
        sql = ["(property_type,property_for,city,state,country,property_title,property_description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,source,more_link);"]

        connection.execute(sql)
      end

      #updating created at and updated at
      Property.update_all({:created_at => Time.now, :updated_at => Time.now})
    end
  end
end