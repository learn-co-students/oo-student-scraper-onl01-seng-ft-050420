require 'open-uri'
require 'pry'
require 'nokogiri'
html =open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
body =Nokogiri::HTML(html)
binding.pry
students=body.css("div.student-card a")
name =each_student.css("h4.student-name")
location =each_student.css("p.student-location")
# a student profile_url

twitter =each_student.body.css("div.social-icon-container a").attribute("href").value
linked_in =each_student
a="https://learn-co-curriculum.github.io/student-scraper-test-page/"
b ="students/ryan-johnson.html"
a+b