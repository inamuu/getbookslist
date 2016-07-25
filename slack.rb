require 'slack/incoming/webhooks'

slack = Slack::Incoming::Webhooks.new "https://hooks.slack.com/services/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"

attachments = [{
  fields: [
    {
    title: "Project",
    value: "#{slackvar}",
    shor: true
  }
  ],
}]

slack.post "", attachments: attachments


