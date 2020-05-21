class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash[:name] = name
    student_hash[:location] = location
    student_hash[:twitter] = twitter
    student_hash[:linkedin] = linkedin
    student_hash[:github] = github
    student_hash[:blog] = blog
    student_hash[:profile_quote] = profile_quote
    student_hash[:bio] = bio
    student_hash[:profile_url] = profile_url
    @@all << self
  end

  def self.create_from_collection(students_array)
    
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    @@all
  end
end

