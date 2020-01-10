require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   # what does this do
   # pulling data via scraping from a web page
   # return value should be an array of hashes each hash represents one student
   # how?
   web_page = Nokogiri::HTML(open(index_url))
   list = []
   students = {}

   web_page.css("div.student-card").each do |student|

     students =
     {
       :name => student.css(".student-name").text,
       :location => student.css(".student-location").text,
       :profile_url => student.css("a").attribute('href').value
     }
     list << students
   end
   list
   # binding.pry

 end

  def self.scrape_profile_page(profile_url)
    # what does this do?
    # uses data from scrape_index_page to add attributes to new instances of Students
    # have to create new instances of students
    student = {}
    web_page = Nokogiri::HTML(open(profile_url))
    doc = web_page.css("div.social-icon-container").children.css("a")
    profile_links = doc.map do |links|
      links.values
    end
    profile_links.flatten.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
      # binding.pry

    end
    student[:profile_quote] = web_page.css(".profile-quote").text if web_page.css(".profile-quote")
    student[:bio] = web_page.css("div.bio-content.content-holder div.description-holder p").text if web_page.css("div.bio-content.content-holder div.description-holder p")
    student

  end

end
