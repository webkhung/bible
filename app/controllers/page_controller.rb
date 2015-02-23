require 'rexml/document'

class PageController < ApplicationController
  include REXML

  READING_PLAN = [
    {
      "id" => "1",
      "days" => ["James.1:14", "Hebrews.2.18", "Hebrews.4.15", "James.4.7", "Romans.6.6-13", "Ephesians6.10-11", "1Peter.5:8-9"]
    },
    {
      "id" => "2",
      "days" => ["1Chronicles.23:30","John.14:27","2Corinthians.12:10,1Timothy.6:12","1Timothy.6:12","Luke.4:32","Philippians.2:14","Romans.5:5","Isaiah.43:19","Titus.2:12","2Corinthians.5:21","2Corinthians.10:5","Matthew.6:26","1Samuel.17:45","Isaiah.61:3"]
    },
    {
      "id" => "3",
      "days" => ["Luke.6:31","Luke.6:35","John.8:13","Romans.12:9","Mark.12:31","Romans.13:10","1Corinthians.13:4-8","1Corinthians.13:13","Ephesians.4:2","1Peter.4:8","1John.4:7","1John.4:18-19","John.15:13","Ephesians.5:25"]
    },
    {
      "id"=> "4",
      "days"=> ["Ephesians.5:33","Colossians.3:14","Proverbs.10:12","Proverbs.17:17","1John.3:16-18","1John.4:8","John.3:16","Psalm.18:1","Matthew.22:27-29","Deuteronomy.10:12-19","Song of Solomon.8:4-8","Matthew.6:24","Matthew.22:37-39","Matthew.23:6-8"]
    },
    {
      "id"=>"5",
      "days"=>["Deuteronomy.28:58-68","Psalm.94:1-23","Jeremiah.17:5-8","Ezekiel.12:1-20","Matthew.6:25-34","Mark.4:35-41","Luke.8:11-15","Luke.10:38-42","John.14:1-14","Philippians.4:4-9"]
    },
    {
      "id"=>"6",
      "days"=>["Exodus.12:31-42","Leviticus.25:38-55,Deuteronomy.15:12-18","Isaiah.58:1-12","Jeremiah.34:8-22","John.8:31-38","Romans.6:15-23","1Corinthians.7:17-24","1Corinthians.9:1-23","1Peter.2:11-17","Galatians.5:1-15"]
    },
    {
      "id"=>"7",
      "days"=>["1Kings.3:3-15","1Kings.3:16-28","Proverbs.8:1-21","Proverbs.8:22-36","Proverbs.9:1-18","Ecclesiastes.1:12-18,Ecclesiastes.2:12-17","Matthew.12:38-42","1Corinthians.1:18-31","1Corinthians.2:1-13","James.1:5-8,James.3:13-18"]
    },
    {
      "id"=>"8",
      "days"=>["Exodus.33:7-11,2Chronicles.20:7","Ruth.1:6-22","1Samuel.18:1-4,.1Samuel.19:1-7,1Samuel.20:1-42","2Samuel.15:32-37,.2Samuel.16:15-19,2Samuel.17:1-16","Job.2:11-13,Job.19:13-22","Psalm.55","Proverbs.13:20,Proverbs.14:20,Proverbs.16:28","Mark.2:1-12","John.11:1-44","John.15:1-17"]
    },
    {
      "id"=>"9",
      "days"=>["Psalm.22,Isaiah.52:13-53:12","Matthew.1:18-25,Luke.2:1-21","Luke.3:1-22,Luke.4:1-13","John.2:1-11,John.3:1-21","John.4:1-42","Luke.4:14-44","Matthew.9:9-13,Luke 5:1-11,John.1:35-51","Luke.6:17-49","Luke.11:1-13,Luke.18:1-14","Matthew.13:1-52","Luke.11:14-53","Mark.4:35-5:20","Mark.5:21-43","Matthew.9:35-10:42","Matthew.14:13-36","Luke.15:1-32","Mark.8:1-30","Mark.9:1-29","Luke.10:25-42","John.7:1-52","John.9:1-41","John.11:1-44","Matthew.19:13-30","Matthew.21:1-27","Luke.21:5-38","Matthew.26:17-56","Mark.14:53-15:15","Matthew.27:32-66","Luke.24:1-35,John.20:1-31","Matthew.28:16-20,Luke.24:50-53,Acts.1:3-11"]
    },
    {
      "id"=>"10",
      "days"=>["Luke 1:1-38","Luke 1:39-80","Luke 2","Luke 3","Luke 4","Luke 5","Luke 6","Luke 7","Luke 8:1-25","Luke 8:26-56","Luke 9:1-36","Luke 9:37-62","Luke 10","Luke 11","Luke 12:1-34","Luke 12:35-59","Luke 13","Luke 14","Luke 15","Luke 16","Luke 17","Luke 18","Luke 19","Luke 20","Luke 21","Luke 22:1-38","Luke 22:39-71","Luke 23:1-25","Luke 23:26-56","Luke 24"]
    },

    {
      "id" => "anger",
      "days" => ["Psalm.22,Isaiah.52:13-53:12"]
    },
    {
      "id" => "anxiety",
      "days" => ["Psalm.22,Isaiah.52:13-53:12"]
    },
    {
      "id" => "depression",
      "days" => ["Psalm.22,Isaiah.52:13-53:12"]
    },
    {
      "id" => "fear",
      "days" => ["Psalm.22,Isaiah.52:13-53:12"]
    },
    {
      "id" => "temptation",
      "days" => ["Psalm.22,Isaiah.52:13-53:12"]
    },
    {
      "id" => "stress",
      "days" => ["Psalm.22,Isaiah.52:13-53:12"]
    },
    {
      "id" => "jealousy",
      "days" => ["Psalm.22,Isaiah.52:13-53:12"]
    },
    {
      "id" => "lonely",
      "days" => ["Psalm.22,Isaiah.52:13-53:12"]
    },
    {
      "id" => "worried",
      "days" => ["Psalm.22,Isaiah.52:13-53:12"]
    }
  ]

  def verses2
    xml = "<?xml version=""1.0"" ?><catalog><book><author>Kelvin</author></book><book><author>Kelvin2</author></book></catalog>"
    xmlDoc = Document.new(xml)

    #author = XPath.first(xmlDoc, "//author")
    #XPath.each(xmlDoc, "//author") { |e| puts e.text }
    #render text: author.text

    root = xmlDoc.root
    xmlDoc.elements.each("catalog/book/author") {
      |e| puts e.text
    }
    render text: "a"
  end

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
    render text: text
  end

  def test
    passage = READING_PLAN.select{ |p| p['id'] == params[:plan_id] }.first["days"][params[:day].to_i - 1]

    url = "https://bibles.org/v2/eng-ESV/passages.json?q[]=#{passage}"

    #url = "https://bibles.org/v2/eng-ESV/passages.xml?q[]=John3.1,Luke2.1"

    c = Curl::Easy.new(url)
    c.http_auth_types = :basic
    c.username = 'wqZRG1WwyhSSh35OZdjGpRJq3acON5PT1YQI1IeW'
    c.follow_location = true
    c.max_redirects = 3
    c.password = 'bar'
    puts c.inspect
    c.perform
    puts "---------------"

    json = JSON.parse(c.body)

    #raise '1'
    passages = ''
    json['passages'].each do |passage|
      passages += "#{passage['text']} (#{passage['reference']})<br>"
    end

    render :text => "#{passages}"

    # "Scripture quotations marked (ESV) are from The Holy Bible, English Standard Version®, copyright © 2001 by Crossway Bibles, a publishing ministry of Good News Publishers. Used by permission. All rights reserved."
  end

end
