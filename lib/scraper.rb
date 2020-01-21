require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # what does this do 
    # pulling data via scraping from the webpage
    # return value should be an arry of hashes each hash represents one student 
    # how? 
    
  students = Nokogiri::HTML (open ("https://learn-co-curriculum.github.io/student-scraper-test-page"))
  students do 
    
   name = students.css(".student-name").text.split(", ")
   location = students.css(".student-location").text.split(", ")
   profile_url = students.css(".view-profile-div").text.split(", ") 

  
  end

  def self.scrape_profile_page(profile_url)
    # what does this do?
    # uses data 
  end

end
 
  