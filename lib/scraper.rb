require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    students_site = Nokogiri::HTML(html)
    student_array = []
    i=0
    #binding.pry
    students_site.css(".student-card").each do |student_card|
      student = {}
      #student_array[i] = {
      #:name => student_card.css("h4").text,
      #:location => student_card.css(".student-location").text,
      #:profile_url => student_card.css("a").attribute("href").value
      student[:name] = student_card.css("h4").text
      student[:location] = student_card.css(".student-location").text
      student[:profile_url] = student_card.css("a").attribute("href").value
      student_array << student
    }
    #i+=1

    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    student = {}
    profile.css(".social-icon-container a").each do |social_profile|

       site = social_profile.attribute("href").value
        if site.include?("twitter")
          student[:twitter] = site
        elsif site.include?("linkedin")
          student[:linkedin] = site
        elsif site.include?("github")
          student[:github] = site
        else
          student[:blog] = site
        end
      end #each
      student[:bio] = profile.css(".description-holder p").text
      student[:profile_quote]=profile.css(".profile-quote").text
    #binding.pry
    student
  end
end
