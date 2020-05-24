#require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  #RETURN AN ARRAY OF HASHES
  def self.scrape_index_page(index_url) #is responsible for scraping the index page that lists all of the students
    doc = Nokogiri::HTML(open(index_url))
    array = []
    doc.css(".student-card").each do |e|
      hash = {}
      hash[:name] = e.css(".student-name").text
      hash[:location] = e.css(".student-location").text
      hash[:profile_url] = e.css("a").first['href']

      array << hash
    end
    array
  end

  def self.scrape_profile_page(profile_url) #is responsible for scraping an individual student's profile page to get further information about that student.
    doc = Nokogiri::HTML(open(profile_url))
    social = doc.css(".main-wrapper.profile")
    hash = {}
    social.css(".vitals-container a").each do |e|
      if e.attributes['href'].value.include?('twitter')
        hash[:twitter] = e.attributes['href'].value
      elsif e.attributes['href'].value.include?('linkedin')
        hash[:linkedin] = e.attributes['href'].value
      elsif e.attributes['href'].value.include?('github')
        hash[:github] = e.attributes['href'].value
      elsif e.attributes['href'].value.include?('.com/')
        hash[:blog] = e.attributes['href'].value
      end
    end
    hash[:profile_quote] = social.css(".profile-quote").text
    hash[:bio] = social.css(".details-container .description-holder p").text

    hash
  end

end
