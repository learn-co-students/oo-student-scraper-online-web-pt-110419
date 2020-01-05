require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    people = []
    html = Nokogiri::HTML(open(index_url))
    html.css('div.student-card').each{|person|
      people << {name: person.css('div.card-text-container h4.student-name').text,
                 location: person.css('div.card-text-container p.student-location').text,
                 profile_url: person.css('a').attribute('href').value}}
    people
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    output = {}

    #  twitter: html.css('div.social-icon-container a')[0].attribute('href').value,
    #  linkedin: html.css('div.social-icon-container a')[1].attribute('href').value,
    #  github: html.css('div.social-icon-container a')[2].attribute('href').value,
    #  blog: html.css('div.social-icon-container a')[3].attribute('href').value,
    #  profile_quote: html.css('div.vitals-text-container div.profile-quote').text,
    #  bio: html.css('div.details-container div.description-holder p').text

    html.css('div.social-icon-container a').each{|socials|
      if socials.attribute('href').value.to_s.include?('twitter')
        output[:twitter] = socials.attribute('href').value
      elsif socials.attribute('href').value.to_s.include?('linkedin')
        output[:linkedin] = socials.attribute('href').value
      elsif socials.attribute('href').value.to_s.include?('github')
        output[:github] = socials.attribute('href').value
      else
        output[:blog] = socials.attribute('href').value
      end}
    output[:profile_quote] = html.css('div.vitals-text-container div.profile-quote').text
    output[:bio] = html.css('div.details-container div.description-holder p').text

    output
  end

end
