require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    i = Nokogiri::HTML(open(index_url))
    selector = i.css("div.roster-cards-container .student-card")
    selector.collect do |person|
      hash = {}
      hash[:name] = person.css("a div.card-text-container h4").text
      hash[:location] = person.css("a div.card-text-container p").text
      hash[:profile_url] = person.css("a").attr('href').text
      hash
    end
  end

  def self.scrape_profile_page(profile_url)
    i = Nokogiri::HTML(open(profile_url))
    selector = i.css(".vitals-container")
    hash = {}
    selector.css(".social-icon-container a").each do |data|
      social_links = data.attr('href')
      if social_links.include?("twitter")
        hash[:twitter] =  social_links
      elsif social_links.include?("linkedin")
        hash[:linkedin] = social_links
      elsif social_links.include?("github")
        hash[:github] = social_links
      else
        hash[:blog] = social_links
      end 
    end
    hash[:profile_quote] = selector.css(".vitals-text-container div").text
    hash[:bio] = i.css(".details-container .bio-block.details-block div div.description-holder p").text
    hash
  end

end

