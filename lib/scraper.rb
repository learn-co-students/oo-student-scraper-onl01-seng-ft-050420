require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students_node = doc.css(".student-card")
    
    students_node.each do |x|
      href = x.css("a").first["href"]
      student_html = open(index_url.gsub("index.html", href))
      students_doc = Nokogiri::HTML(student_html)
      student_info = students_doc.css(".vitals-text-container")
      student_name = student_info.css(".profile-name").text
      student_location = student_info.css(".profile-location").text
     
      student_array << {:name => student_name, :location => student_location, :profile_url => href}
    end
    
    return student_array  
    
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_media = doc.css(".social-icon-container")
    
    twitter = ""
    linkedin = ""
    github = ""
    blog = ""

    social_media.css("a").each do |x|
      
      link = x["href"]
      
      if link.include? "twitter"
        student_hash[:twitter]  = link
      elsif link.include? "linkedin"
        student_hash[:linkedin]  = link
      elsif link.include? "github"
        student_hash[:github]  = link
      else 
        student_hash[:blog]  = link
      end
    end
    
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".details-container").css(".bio-block.details-block").css(".bio-content.content-holder").css(".description-holder").css("p").text
    
    return student_hash
  end

end

hash = Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/kevin-mccormack.html")

puts hash