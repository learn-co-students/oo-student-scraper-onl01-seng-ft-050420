require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    
    doc = Nokogiri::HTML(html)
    
    students = []
    #binding.pry
    
    doc.css("div.student-card").select do |student|
      students << {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").value
      }
    end
    students
    
  end

  def self.scrape_profile_page(profile_url)
    
     students_hash = {}

    html = Nokogiri::HTML(open(profile_url))
    #binding.pry
    html.css("div.social-icon-container a").each do |student|
        s_media = student.attribute("href").value
        if s_media.include?("twitter")
          students_hash[:twitter] = s_media
        elsif s_media.include?("linkedin")
          students_hash[:linkedin] = s_media
        elsif s_media.include?("github")
          students_hash[:github] = s_media 
        else
          students_hash[:blog] = s_media 
        end
      end
      students_hash[:profile_quote] = html.css("div.profile-quote").text
      students_hash[:bio] = html.css("div.bio-content p").text
    students_hash
  end


end

#html.css("div.social-icon-container a").attribute("href").value
#html.css("div.social-icon-container a").map{|student| student.attribute("href").value}
