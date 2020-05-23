require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_card_list = doc.css(".student-card")
    student_card_list.map do |student|
      {
        name: student.css("h4.student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
      
    # binding.pry
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    attribute_hash = {}
    social_media_list = doc.css("div.social-icon-container a")
    
    social_media_list.map do |element|
      link = element.attribute("href").value
      if link.include?('twitter')
        attribute_hash[:twitter] = link
      elsif link.include?('linkedin')
        attribute_hash[:linkedin] = link
      elsif link.include?('github')
        attribute_hash[:github] = link
      else
        attribute_hash[:blog] = link
      end
    end
    attribute_hash[:profile_quote] = doc.css(".profile-quote").text
    attribute_hash[:bio] = doc.css(".bio-content .description-holder p").text
    # binding.pry
    attribute_hash
  end
end

# element.attribute("href").value


# student.css("h4.student-name").text => name value
# student.css(".student-location").text => location
# student.css("a").attribute("href").value => profile url