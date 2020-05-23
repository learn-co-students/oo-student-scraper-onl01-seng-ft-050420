require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index = Nokogiri::HTML(html)
    students = []
    index.css("div.student-card").each do |student|
      student_info = {}
      student_info = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    student_profile = {}
    profile.css("div.main-wrapper.profile .social-icon-container a").each do |link|
      if link.attribute("href").value.include?("twitter")
        student_profile[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github")
        student_profile[:github] = link.attribute("href").value
      else
        student_profile[:blog] = link.attribute("href").value
      end
    end
    student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text
    student_profile
  end

end
