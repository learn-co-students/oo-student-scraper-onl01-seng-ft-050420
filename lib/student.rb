class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # self.send('name=', student_hash[:name])
    # self.send('location=', student_hash[:location])
    # self.send('profile_url=', student_hash[:profile_url])
    #
    # # binding.pry
    student_hash.each_pair do |key, value|
      send("#{key}=",value)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)

 students_array.each do |element|
    Student.new(element)
 end
  end

  def add_student_attributes(attributes_hash)

  attributes_hash.each_pair do |key, value|
    send("#{key}=", value)
  end
  self
  end

  def self.all
    @@all
  end
end

# @name = :name
# @location = :location
# @twitter = :twitter
# @linkedin = :linkedin
# @github = :github
# @blog = :blog
# @profile_quoute = :profile_quote
# @bio = :bio
# @profile_url = :profile_url
