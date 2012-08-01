namespace :db do
  namespace :load do
    desc "Load Properties into DB"
    task :properties => :environment do
      #Mysql2::Client.default_query_options[:connect_flags] |= Mysql2::Client::LOCAL_FILES
      @files = Dir.entries("db/properties_data")
      connection = ActiveRecord::Base.connection()

      for file in @files
        next if file == "." || file == ".."
        sql = "LOAD DATA LOCAL INFILE '/home/ranjith/Projects/vollaa/db/properties_data/#{file}'
               INTO TABLE properties
               FIELDS TERMINATED BY '|'
               LINES TERMINATED BY '\\n'
               (property_type,property_for,city,state,country,property_title,property_description,property_price,built_up_area,bedrooms,property_age,last_update,property_image,source,more_link);"

        connection.execute(sql)
      end
    end
  end
end