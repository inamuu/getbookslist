require 'yaml'
require 'open-uri'
require 'nokogiri'
require 'slack/incoming/webhooks'

list = YAML.load_file("list.yaml")

list['siteurl'].each do | url |

  doc = Nokogiri::HTML(open(url).read)
  arr = Array.new
  doc.xpath('//h2[@class="entry-title"]').each do | node |
    arr << node.text + "\n"
  end

  str = arr.join
  str = str.gsub!(/\[(?!Novel).*/, '')

  slack = Slack::Incoming::Webhooks.new "https://hooks.slack.com/services/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"
  
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
