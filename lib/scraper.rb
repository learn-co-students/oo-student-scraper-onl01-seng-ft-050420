require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    url = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"
    doc = Nokogiri::HTML(open(url))
    all_information = doc.css("div.roster-cards-container")
    
    students = {}
    
    all_information.each do |roster|
      students = {
      :name => roster.css("h4.student-name").text
      :location => roster.css("p.student-location").text
      :profile_url => roster.css("div.student-card a").attr('href').value
      }
      binding.pry
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

