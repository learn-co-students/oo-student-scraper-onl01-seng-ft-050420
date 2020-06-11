require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)

    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_hash_array = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        student_hash_array << {:name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css("a").attribute("href").text
      }
        end
      end
      student_hash_array
  end   

    def self.scrape_profile_page(profile_url)
      doc = Nokogiri::HTML(open(profile_url))
      student = {}
      container = doc.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      container.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
        end
      end
      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css("div.description-holder p").text
      student
  end

end

