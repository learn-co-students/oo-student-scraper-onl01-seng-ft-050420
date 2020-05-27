require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  index_url ="https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"
  def self.scrape_index_page(index_url)
    file=open(index_url)
    body=Nokogiri::HTML(file)
    all_students=body.css("div.student-card")
    students=[]
    all_students.each do |student|
      each_student={}
      each_student[:name] =student.css("h4.student-name").text
      each_student[:location] =student.css("p.student-location").text
      each_student[:profile_url]=student.css("a").attribute("href").value
      students << each_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    file=open(profile_url)
    profile=Nokogiri::HTML(file)
    student_profile={}
    profile.css("div.social-icon-container a").each do |socialmedia|
      if socialmedia.attribute("href").value.include?("twitter")
              student_profile[:twitter]=socialmedia.attribute("href").value
      elsif socialmedia.attribute("href").value.include?("linkedin")
              student_profile[:linkedin]=socialmedia.attribute("href").value
      elsif socialmedia.attribute("href").value.include?("github")
              student_profile[:github]=socialmedia.attribute("href").value
      elsif socialmedia.attribute("href").value.include?(".com")
              student_profile[:blog]=socialmedia.attribute("href").value
      end
      student_profile[:profile_quote]=profile.css("div.profile-quote").text
      student_profile[:bio]=profile.css("div.description-holder p").text
    end
    student_profile
  end

end


