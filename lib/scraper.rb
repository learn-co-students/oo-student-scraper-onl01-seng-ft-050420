require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    url = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"
    doc = Nokogiri::HTML(open(url))
    all_information = doc.css("div.roster-cards-container")
    
    students = []
    
    all_information.each do |roster|
      roster.css("div.student-card a").each do |student|
      
      student_hash = {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.attr("href")
      }
        students << student_hash
      end
    end 
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_icons = doc.css("div.social-icon-container a")
    quote = doc.css("div.profile-quote").text
    bio = doc.css("div.description-holder p").text

    socials = {}

    socials[:bio] = bio
    socials[:profile_quote] = quote
  
    social_icons.each do |social|
      social_sm = social.attr("href")
      if social_sm.include?("twitter")
        socials[:twitter] = social_sm
      elsif social_sm.include?("linked")
        socials[:linkedin] = social_sm
      elsif social_sm.include?("github")
        socials[:github] = social_sm
      else
        socials[:blog] = social_sm
      end
    end
      socials
  end
    
    
end

