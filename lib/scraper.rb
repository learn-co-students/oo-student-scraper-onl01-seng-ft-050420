require 'open-uri'
require 'pry'
require 'nokogiri' 
 
class Scraper
 
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

# profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    container = profile_page.css(".social-icon-container").children.css("a").map {|icon| icon.attribute("href").value}
      container.each do |link|
        if link.include?("twitter")
            student[:twitter] = link
        elsif link.include?("linkedin")
            student[:linkedin] = link
        elsif link.include?("github")
            student[:github] = link
        elsif link.include?(".com/")
            student[:blog] = link
        end
      end
      student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
      #  div.vitals-text-container 
      # div class="profile-quote
      
      # div.details-container
      # /html/body/div/div[2]/div[3]/div
      student[:bio] = profile_page.css("div.description-holder p").text if profile_page.css("div.description-holder p")
      student
  end
end

# <div class="social-icon-container">
#           <a href="https://twitter.com/empireofryan"><img class="social-icon" src="../assets/img/twitter-icon.png"></a>
#           <a href="https://www.linkedin.com/in/ryan-johnson-321629ab"><img class="social-icon" src="../assets/img/linkedin-icon.png"></a>
#           <a href="https://github.com/empireofryan"><img class="social-icon" src="../assets/img/github-icon.png"></a>
#           <a href="https://www.youtube.com/watch?v=C22ufOqDyaE"><img class="social-icon" src="../assets/img/rss-icon.png"></a>
#         </div>
