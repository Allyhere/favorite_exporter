require 'nokogiri'
require 'open-uri'
require 'rubygems'


uri = './parseable.html'
doc = Nokogiri::HTML(open(uri))
doc.css('script, link').each { |node| node.remove }
formatted = doc.css('body')


headers_regex = /^(\s{8}\w)/
titles_regex = /^(\s{12}\w)/
folder = []
formatted.to_s.split(/\n/) do |line|
  puts line.scan(/>\w.*</).join.gsub(/(>|<)/, "") if line.include?("last_modified")
end

puts folder
# output
File.open("favorites.txt", "w") {|f| f.write(formatted.to_s) }