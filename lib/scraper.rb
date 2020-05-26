require 'open-uri'
require 'pry'

class Scraper
  
  

  def self.scrape_index_page(index_url)
    
    html = open(index_url)
    
    file = Nokogiri::HTML(html)
    students = file.css(".student-card")
    students_arr = []
    

    students.collect do |c|
      students_arr << {
        :name => c.css("h4.student-name").text,
        :location => c.css("p.student-location").text,
        :profile_url => c.css("a").attribute("href").value
      }
    end
    students_arr
  end
  
  
  

  def self.scrape_profile_page(profile_url)

    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    attributes = {}

    doc.css("div.social-icon-container a").each do |xml|
      case xml.attribute("href").value

      when /github/
        attributes[:github] = xml.attribute("href").value
      when /linkedin/
        attributes[:linkedin] = xml.attribute("href").value      
      when /twitter/
        attributes[:twitter] = xml.attribute("href").value
      else
        attributes[:blog] = xml.attribute("href").value
      end

    end
    attributes[:profile_quote] = doc.css("div.profile-quote").text
    attributes[:bio] = doc.css("div.bio-content div.description-holder").text.strip
    attributes
  end
  

end

