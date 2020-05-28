require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    url = open(index_url)
    doc = Nokogiri::HTML(url)
    students = doc.css(".student-card a")
    students.collect do |student|
    {:name => student.css(".student-name").text , 
    :location => student.css(".student-location").text , 
    :profile_url => student.attr('href')}
    end
  end
  
  def self.scrape_profile_page(profile_url)
    url = open(profile_url)
    doc = Nokogiri::HTML(url)
    profile = {}
    
    student = doc.css(".vitals-container .social-icon-container a")
    student.each do |page|
      
    if page.attr('href').include?("twitter")
    profile[:twitter] = page.attr('href')
      elsif page.attr('href').include?("linkedin")
      profile[:linkedin] = page.attr('href')
    elsif page.attr('href').include?("github") 
      profile[:github] = page.attr('href')
    elsif page.attr('href').end_with?("com/")
      profile[:blog] = page.attr('href')
    end
  end
    profile[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
    profile[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder").text.strip
    profile
    
  end
  

    
    

end
