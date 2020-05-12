require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    student_card_list = doc.css(".student-card")
    student_card_list.collect do |card|
      {
        :name => card.css(".card-text-container .student-name").text,
        :location => card.css(".card-text-container .student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
    attributes_hash = {}
    social_media_list = doc.css(".social-icon-container a").collect{|el| el.attribute("href").value}
    social_media_list.each do |link|
      if link.include?("twitter")
        attributes_hash[:twitter] = link
      elsif link.include?("linkedin")
        attributes_hash[:linkedin] = link
      elsif link.include?("github")
        attributes_hash[:github] = link
      else 
        attributes_hash[:blog] = link
      end
    end
    attributes_hash[:profile_quote] = doc.css(".profile-quote").text.strip
    attributes_hash[:bio] = doc.css(".bio-content .description-holder p").text
    attributes_hash
  end

end

