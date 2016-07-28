#!/usr/bin/env ruby 

require 'yaml'
require 'open-uri'
require 'nokogiri'
require 'slack/incoming/webhooks'
require 'dotenv'

list = YAML.load_file("list.yaml")

list['siteurl'].each do | url |

  doc = Nokogiri::HTML(open(url).read)
  arr = Array.new
  doc.xpath('//h2[@class="entry-title"]').each do | node |
    arr << node.text + "\n"
  end

  str = arr.join
  str = str.gsub!(/\[(?!Novel).*/, '')

  Dotenv.load
  slack = Slack::Incoming::Webhooks.new ENV["APIKEY"]
  
  attachments = [{
    color: "#483D8B",
    fields: [
      {
      title: "今日の書籍一覧",
      value: "#{str}",
      }
    ],
  }]
  
  slack.post "", attachments: attachments

end
