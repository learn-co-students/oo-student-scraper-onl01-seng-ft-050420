require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    i = 0
    while i < doc.css(".student-card").length
        students[i] = {}
       students[i][:name] = doc.css(".student-name")[i].text
       students[i][:location] = doc.css(".student-location")[i].text
       students[i][:profile_url] = doc.css(".student-card a").map{|link| link["href"]}[i]
       i+=1
     end
      students
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    doc = Nokogiri::HTML(open(profile_url))
      links = doc.css(".social-icon-container a").collect{|a| a["href"]}
      links.each do |link|
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
      hash[:profile_quote] = doc.css(".profile-quote").text
      hash[:bio] = doc.css(".bio-block p").text
      hash
  end
  

end