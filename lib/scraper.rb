require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  def self.scrape_index_page(index_url)
    array = []
    get_page = Nokogiri::HTML(open(index_url))
    get_page.css("div.roster-cards-container").each do |student|
      student.css(".student-card a").each do |student|
      student_name = student.css("h4").text
      student_location = student.css("p").text
      student_profile = "#{student.attr('href')}"
      array << {name: student_name, location: student_location, profile_url: student_profile}
    end
  end

  array
  end
  
  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    student
  end

end


