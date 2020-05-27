require_relative './scraper.rb'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.send("#{key}=",value)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      # student.delete(:profile_url)
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attribute, value|
      # if self.(#{attribute}) !=nil 
        self.send("#{attribute}=", value)
      # end
    end
     self 
  end
     
  def self.all
    @@all
  end
end

# url="https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"
# students_array =Scraper.scrape_index_page(url)
# Student.create_from_collection(students_array)
# binding.pry

