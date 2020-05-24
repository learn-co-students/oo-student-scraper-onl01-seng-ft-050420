require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    student_info = doc.css(".student-card a") 
    student_info.collect do |student| 
      {:name => student.css(".student-name").text, 
        :location => student.css(".student-location").text, 
        :profile_url => student.attr('href')}
    end 
  end

  def self.scrape_profile_page(profile_url)
    social_hash = {}
    doc = Nokogiri::HTML(open(profile_url))

    doc.css("div.main-wrapper.profile .social-icon-container a").each do |x|
      if x.attr("href").include?("twitter")
        social_hash[:twitter] = x.attr("href") 
      elsif x.attr("href").include?("linkedin")
        social_hash[:linkedin] = x.attr("href")
      elsif x.attr("href").include?("github")
        social_hash[:github] = x.attr("href")
      else x.attr("href").include?(".com")
        social_hash[:blog] = x.attr("href")
      end 
    end 
    social_hash[:profile_quote] = doc.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text 
    social_hash[:bio] = doc.css("div.main-wrapper.profile .description-holder p").text 
    social_hash
  end

end

