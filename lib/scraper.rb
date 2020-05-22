require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    page.css(".student-card").collect do |student| 
      {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    hash = {}
    socials = page.css(".vitals-container a").collect do |link|
      link.attribute("href").value
    end
    #binding.pry

    socials.each do |link|
      if link.include?("twitter")
        hash[:twitter] = link
      elsif link.include?("linkedin")
        hash[:linkedin] = link
      elsif link.include?("github")
        hash[:github] = link
      else 
        hash[:blog] = link
      end
    end

    hash[:profile_quote] = page.css(".profile-quote").text
    hash[:bio] = page.css(".details-container p").text
    #binding.pry
    hash
  end
end

