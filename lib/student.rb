require 'pry'
class Student

  attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :github, :blog, :profile_quote, :bio

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(students_array)
      students_array.each do |student_hash| self.new(student_hash) 
    end
  end

  def add_student_attributes(attributes_hash)
      attributes_hash.each do |key, value| self.send(("#{key}="), value)
    end
  end

  def self.all
    @@all
  end
end

