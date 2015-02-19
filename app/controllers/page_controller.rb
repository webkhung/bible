require 'rexml/document'

class PageController < ApplicationController
  include REXML

  READING_PLAN = [
    {
      "id" => "1",
      "name" => "Temptation",
      "description" => "Temptation comes in so many forms. And it is easy to excuse our decisions and justify ourselves. This seven-day plan shows you that you can overcome temptation, through the Spirit of God. Take time to quiet your mind, let God speak into your life, and you will find strength to overcome the greatest temptations.",
      "days" => ["James.1:14", "Hebrews.2.18", "Hebrews.4.15", "James.4.7", "Romans.6.6-13", "Ephesians6.10-11", "1Peter.5:8-9"]
    },
    {
      "id" => "2",
      "name" => "The power of being thankful",
      "description" => "giving thanks to God daily will positively impact our lives. When we pause to acknowledge His blessings it restores us to a state of spiritual peace. In this reading plan you'll find fourteen inspiring messages that will spark an attitude of gratitude in our hearts. Through uplifting Scripture, she illustrates God's never-ending love, inexhaustible grace, and always-accessible presence in our lives.",
      "days" => ["1Chronicles.23:30","John.14:27","2Corinthians.12:10,1Timothy.6:12","1Timothy.6:12","Luke.4:32","Philippians.2:14","Romans.5:5","Isaiah.43:19","Titus.2:12","2Corinthians.5:21","2Corinthians.10:5","Matthew.6:26","1Samuel.17:45","Isaiah.61:3"]
    },
    {"name" => "temptation", "id" => '3', "description"=> "TTT", "days"=> ["Hebrews.2.18", "Hebrews.4.15", "James.4.7", "Romans.6.6-13", "Ephesians6.10-11", "1Peter.5.8-9"]},
    {"name"=> "temptation2", "id" => '4', "description"=> "TTT", "days"=> ["James.4.7", "Romans.6.6-13", "Ephesians6.10-11", "1Peter.5.8-9"]},
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
