require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_hash = []
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect{|student|
      hash = {
        name: student.css('h4.student-name').text,
        location: student.css('p.student-location').text,
        profile_url: student.css('a').attribute('href').text
      }
      student_hash << hash
    }
    student_hash
  end

  def self.scrape_profile_page(profile_url)
    students_hash = {}
    html = Nokogiri::HTML(open(profile_url))
    html.css("div.main-wrapper.profile .social-icon-container a").each do |student|
        if student.attribute('href').value.include?('twitter')
          students_hash[:twitter] = student.attribute('href').value
        elsif student.attribute('href').value.include?('linkedin')
          students_hash[:linkedin] = student.attribute('href').value
        elsif student.attribute('href').value.include?('github')
          students_hash[:github] = student.attribute('href').value
        else
          students_hash[:blog] = student.attribute('href').value
        end
    end
        students_hash[:profile_quote] = html.css("div.profile-quote").text
        students_hash[:bio] = html.css("div.bio-content p").text
        #binding.pry
        students_hash
  end
end
