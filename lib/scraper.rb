require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css("div.student-card")
    students = []

    
    student_cards.each { |student_profile|
      student = {
        :name => student_profile.css("h4.student-name").text,
        :location => student_profile.css("p.student-location").text,
        :profile_url => student_profile.css("a")[0].attributes["href"].value
      }
      students << student
    }
    
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    # student_info = {
    #   :twitter => doc.css("a")[1].attributes["href"].value,
    #   :linkedin => doc.css("a")[2].attributes["href"].value,
    #   :github => doc.css("a")[3].attributes["href"].value,
    #   :blog => doc.css("a")[4].attributes["href"].value,
    #   :profile_quote => doc.css("div.profile-quote").text,
    #   :bio => doc.css("p").text
    # }
    student_info = {}

    links = doc.css('a').collect { |link|
      link.attributes['href'].text

    }
    name = doc.css('h1.profile-name').text
    name = name.split(' ')
    name = name[0].downcase
    twitter_atr = links.select {|link| link.include?("twitter")}
    linkedin_atr = links.select {|link| link.include?("linkedin")}
    github_atr= links.select {|link| link.include?("github")}
    blog_atr =links.select {|link| link.include?(name)}
    # Realized the way to go is iterate though links array to do select on each one that includes the attribute
    # and set it to a variable.  We can then do if variable.empty? != true -----> set the value on the student info.

    if twitter_atr.empty? != true
      student_info[:twitter] = twitter_atr[0]
     end

    if linkedin_atr.empty? != true
      student_info[:linkedin] = linkedin_atr[0]
    end

    if github_atr.empty? != true
      student_info[:github] = github_atr[0]
    end

    if blog_atr.empty? != true && blog_atr != linkedin_atr
      student_info[:blog] = blog_atr[0]
    end

    student_info[:profile_quote] = doc.css("div.profile-quote").text
    student_info[:bio] = doc.css("p").text
    student_info
  end

end

