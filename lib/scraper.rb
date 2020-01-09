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
  end

end
