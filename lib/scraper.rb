require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card").each do |student|
        student_profile_link = "#{student.css('a').attribute('href').value}"
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        scraped_students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    scraped_students

  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))
    profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute('href').value.include?('twitter')
        student[:twitter] = social.attribute("href").value
      elsif social.attribute('href').value.include?('linkedin')
        student[:linkedin] = social.attribute('href').value
      elsif social.attribute('href').value.include?('github')
        student[:github] = social.attribute('href').value
      else
        student[:blog] = social.attribute('href').value
        end
    end
    student[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student[:bio]= profile.css("div.main-wrapper.profile .description-holder p").text

    student
  end

end
