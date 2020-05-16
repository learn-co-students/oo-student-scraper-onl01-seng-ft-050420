require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :students

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card")
    students = []
    
    student_cards.map do |card|
      students << {
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    attributes = {}

    doc.css("div.social-icon-container a").each do |xml|
      case xml.attribute("href").value
      
      when /github/
        attributes[:github] = xml.attribute("href").value
      when /linkedin/
        attributes[:linkedin] = xml.attribute("href").value      
      when /twitter/
        attributes[:twitter] = xml.attribute("href").value
      else
        attributes[:blog] = xml.attribute("href").value
      end
      
    end
    attributes[:profile_quote] = doc.css("div.profile-quote").text
    attributes[:bio] = doc.css("div.bio-content div.description-holder").text.strip
    attributes
  end

end

