require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = Array.new
    html = open(index_url)
    node_set= Nokogiri::HTML(html)
    
    node_set.css("div.student-card").each do |student|
      hash = {}
      hash[:name] = student.css("h4.student-name").text
      hash[:location] = student.css("p.student-location").text
      hash[:profile_url] = student.css("a").attribute("href").value
      student_array.push(hash)
    end 
    student_array
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    html = open(profile_url)
    node_set= Nokogiri::HTML(html)
    
    node_set.css("div.main-wrapper div.vitals-container div.social-icon-container a").each do |student|
      if student.attribute('href').value.include?("twitter")
        hash[:twitter] = student.attribute('href').value
      elsif student.attribute('href').value.include?('linkedin')
        hash[:linkedin] = student.attribute('href').value 
      elsif student.attribute('href').value.include?('github')
        hash[:github] = student.attribute('href').value 
      else 
        hash[:blog] = student.attribute('href').value  
      end 
    end 
      
      hash[:profile_quote] = node_set.css('div.main-wrapper div.vitals-container div.profile-quote').text
      hash[:bio] = node_set.css('div.main-wrapper div.details-container div.bio-content div.description-holder').text.strip
      
      #binding.pry
   
    hash
  end
  
  def self.create_out_of_array(array)
    array.each{|student| Student.new(student)}
  end 
  
  def self.add_attr(student, hash)
    hash.each {|key, value| student.send("#{key}=", value)}
  end 

end

