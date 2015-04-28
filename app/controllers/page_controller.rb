require 'rexml/document'

class PageController < ApplicationController
  include REXML

  # you can put two verses together  "2Corinthians.12:10,1Timothy.6:12"
  READING_PLAN = [
    {
      "id"=> "1",
      "days" => ["1Chronicles.23:30","John.14:27","2Corinthians.12:10","1Timothy.6:12","Luke.4:32","Philippians.2:14","Romans.5:5","Isaiah.43:19","Titus.2:12","2Corinthians.5:21","2Corinthians.10:5","Matthew.6:26","1Samuel.17:45","Isaiah.61:3"]
    },
    {
      "id"=> "2",
      "days" => ["Luke.6:31","Luke.6:35","John.8:13","Romans.12:9","Mark.12:31","Romans.13:10","1Corinthians.13:4-8","1Corinthians.13:13","Ephesians.4:2","1Peter.4:8","1John.4:7","1John.4:18-19","John.15:13","Ephesians.5:25"]
    },
    {
      "id"=> "3",
      "days"=> ["Ephesians.5:33","Colossians.3:14","Proverbs.10:12","Proverbs.17:17","1John.3:16-18","1John.4:8","John.3:16","Psalm.18:1","Matthew.22:27-29","Deuteronomy.10:12-19","Song of Solomon.8:4-8","Matthew.6:24","Matthew.22:37-39","Matthew.23:6-8"]
    },
    {
      "id"=> "4",
      "days" => ["James.1:14", "Hebrews.2.18", "Hebrews.4.15", "James.4.7", "Romans.6.6-13", "Ephesians6.10-11", "1Peter.5:8-9"]
    },
    {
      "id"=>"5",
      "days"=> ["Proverbs.3:5-6", "Philippians.4:6-7", "Matthew.11:28-30", "John.14:27", "Jeremiah.17:5-8", "Colossians.3:15", "2Thessalonians.3:16", "Psalm.55:22", "Proverbs.12:25", "1Peter.5:6-8", "Psalm.23:4", "Hebrews.13:5-6"]
    },
    {
      "id"=>"6",
      "days"=> ["Matthew.6:14-15","1John.1:9","Isaiah.43:25-26","Acts.3:19","Isaiah.1:18","2.Corinthians.5:17","Ephesians.1:7","Hebrews.10:17","Daniel.9:9","Colossians.1:13-14","Psalm.103:12","Numbers.14:19-21","Micah.7:18-19","Matthew.6:9-15","Mark.11:25","Matthew.26:28"]
    },
    {
      "id"=>"7",
      "days"=> ["Proverbs.18:10","Proverbs.3:5-6","Isaiah.41:10","John.14:27","John.16:33","Psalm.46:1-3","2Timothy.1:7","Psalm.16:8","Psalm.55:22","1Peter.5:7","Isaiah 26:3","Psalm 118:14-16","Psalm 119:114-115","Psalm 119:25","Psalm 119:50","Psalm 119:71","Psalm 120:1"]
    },
    {
      "id"=>"8",
      "days"=> ["James.1:19-20","Proverbs.29:11","James.1:20","Proverbs.19:11","Ecclesiastes.7:9","Proverbs.15:1","Proverbs.15:18","Colossians.3:8","James.4:1-2","Proverbs.16:32","Proverbs.22:24","Matthew.5:22","Psalm.37:8-9","Psalm.7:11","2 Kings.11:9-10","2 Kings.17:18","Proverbs.14:29"]
    },
    {
      "id"=>"9",
      "days"=> ["Philippians.4:13","Psalm.37:4","Psalm.1:1-3","Proverbs.16:3","1.Kings 2:3","Matthew.16:26-27","Luke.16:10-11","Romans.12:2","Isaiah.41:10","Philippians.4:6","Deuteronomy.8:18","Jeremiah.17:7"]
    },
    {
      "id"=>"10",
      "days"=> ["1Corinthians.6:19-20", "1Corinthians.3:16-17","Romans.12:1-2","1Corinthians.10:31","1Timothy.4:8","1Timothy.5:23","Matthew.6:22-23","1Corinthians.15:44","Philippians.1:20","1Corinthians.12:27","Psalm.100:3","Romans.12:4"]
    },
    {
      "id"=>"11",
      "days"=> ["Matthew.6:21","Malachi.3:10","Ecclesiastes.5:10","Romans.13:8","Psalm 37:16-17","Proverbs 13:11","Hebrews 13:5","Matthew 19:21","Proverbs 17:16","Matthew 6:24","Luke 3:14","Exodus 22:25","1 Timothy 6:10","Deuteronomy 23:19","Matthew 21:12-13","1 Timothy 6:17-19","Luke 12:33","Deuteronomy 15:7","Matthew 6:1-4","Mark 12:41-44","Proverbs 10:4","Revelation 3:17","Luke 16:13","Matthew 13:22","2 Chronicles 1:11-12","1 Peter 5:2-3","1 Samuel 2:7","Proverbs 3:9"]
    },
    #{
    #  "id" => "anger",
    #  "days" => ["Romans.12:17-18,21,Ephesians.4:26,Proverbs.15:1,Prov.19:11"]
    #},
    #{
    #  "id" => "anxiety",
    #  "days" => ["Matthew.6:25,31,33"]
    #},
    #{
    #  "id" => "depression",
    #  "days" => ["Psalm.3:3-5,Psalm.30:5,Psalm.40:1-2,Psalm.42:11,Psalm.147:3"]
    #},
    #{
    #  "id" => "fear",
    #  "days" => ["2Timothy.1:7,Psalm.31:24,Psalm.91:10,Psalm.121:1-2"]
    #},
    #{
    #  "id" => "temptation",
    #  "days" => ["Matthew.26:41,1Corinthians.10:13,James.4:7,2Peter.2:9,Psalm.119:11"]
    #},
    #{
    #  "id" => "stress",
    #  "days" => ["Matthew.11:28,Philippians.4:11-13,Psalm.9:9,Psalm.27:5,Psalm.34:4"]
    #},
    #{
    #  "id" => "lonely",
    #  "days" => ["Psalm.27:10,Psalm.143:8,Hebrews.13:5,1Peter.5:7"]
    #},
    #{
    #  "id" => "worried",
    #  "days" => ["Matthew.6:19-34,1Peter.5:6-7"]
    #}
  ]

  def verses
    passage = READING_PLAN.select{ |p| p['id'] == params[:plan_id] }.first["days"][params[:day].to_i - 1]
    url = "https://bibles.org/v2/eng-ESV/passages.xml?q[]=#{passage}"
    c = Curl::Easy.new(url)
    c.http_auth_types = :basic
    c.username = 'wqZRG1WwyhSSh35OZdjGpRJq3acON5PT1YQI1IeW'
    c.follow_location = true
    c.max_redirects = 3
    c.password = 'bar'
    puts c.inspect
    c.perform

    text = ''
    xmlDoc = Document.new(c.body)
    XPath.each(xmlDoc, "//passage") do |e|
      text += e.elements['text'].text
      text += '<div class=scripture>' + e.elements['display'].text + '</div>'
    end

    log_usage('READ')

    render text: text
  end

  def finished
    log_usage('FINISHED')
    render nothing: true, status: 200
  end

  def answered
    log_usage('ANSWER')
    render nothing: true, status: 200
  end

  def usage
    log_usage(params[:usage_type])
    render nothing: true, status: 200
  end

  def report

  end

  def users
    output = '<li id=user-header>LEADERBOARD:</li>';
    Usage.group('user_name').order('count(*) desc').count.each do |user|
      output << "<li>#{user[0]}</li>"
    end
    render text: "<ul>#{output}</ul>"
  end

  private

  def log_usage(usage_type)
    Usage.create!(
      plan_id: params[:plan_id].to_i,
      day: params[:day].to_i,
      user_id: params[:user_id],
      user_name: params[:user_name],
      details: params[:details].presence,
      ip: request.ip,
      usage_type: usage_type
    )
  end

end
