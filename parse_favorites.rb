require 'nokogiri'
require 'open-uri'
require 'rubygems'


uri = './parseable.html'
doc = Nokogiri::HTML(open(uri))
doc.css('script, link').each { |node| node.remove }
formatted = doc.css('body')

folder = []
folder_level = 0
formatted.to_s.split(/\n/) do |line|
  if line.include?("H3")
    folder << line.scan(/>\w.*</).join.gsub(/(>|<)/, "")
    2.times { next }
    folder << line.scan(/>\w.*</).join.gsub(/(>|<)/, "") until line.include?("dl><p")
  end
end

puts folder
# output
File.open("favorites.txt", "w") {|f| f.write(formatted.to_s) }