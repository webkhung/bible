class PageController < ApplicationController

  READING_PLAN = [
      {"name" => "temptation", "id" => 1, "description"=> "TTT", "days"=> ["James.1.14,Hebrews.2.18", "Hebrews.2.18", "Hebrews.4.15", "James.4.7", "Romans.6.6-13", "Ephesians6.10-11", "1Peter.5.8-9"]},
      {"name"=> "temptation2", "id" => 2, "description"=> "TTT", "days"=> ["James.1.14", "Hebrews.2.18", "Hebrews.4.15", "James.4.7", "Romans.6.6-13", "Ephesians6.10-11", "1Peter.5.8-9"]},
  ]

  def verses

    passage = READING_PLAN.select{ |p| p['id'] = params[:plan_id] }.first["days"][params[:day].to_i]

    url = "https://bibles.org/v2/eng-ESV/passages.json?q[]=#{passage}"

    #url = "https://bibles.org/v2/eng-ESV/passages.xml?q[]=John3.1,Luke2.1"

    c = Curl::Easy.new(url)
    c.http_auth_types = :basic
    c.username = 'wqZRG1WwyhSSh35OZdjGpRJq3acON5PT1YQI1IeW'
    c.follow_location = true
    c.max_redirects = 3
    c.password = 'bar'
    c.perform

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
