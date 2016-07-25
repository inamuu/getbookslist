require 'yaml'
require 'open-uri'
require 'nokogiri'
require './slack.rb'

list = YAML.load_file("list.yaml")

list['siteurl'].each do | url |

#  puts "RSS Feed Info"
#  xml = Nokogiri::XML(open(url).read)
#  node = xml.xpath('//item')
#  node.each do | item |
#    puts item.xpath("title").text
#    puts item.xpath("link").text
#    puts "\n"
#  end

  doc = Nokogiri::HTML(open(url).read)
  puts "=== Info === "
  p doc.title
  doc.xpath('//h2[@class="entry-title"]').each do | node |
    slackvar = node.text
  end
end

