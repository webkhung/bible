require 'rexml/document'

class PageController < ApplicationController
  include REXML

  # you can put two verses together  "2Corinthians.12:10,1Timothy.6:12"
  READING_PLAN = [
    {
      "id"=> "1",
      "days" => ["1Chronicles.23:30","John.14:27","Romans.5:5","Matthew.6:26","Psalm.20:4","Colossians.3:17","1Thessalonians.5:18","James.1:17","Philippians.4:6"]
    },
    {
      "id"=> "2",
      "days" => ["Luke.6:31","Luke.6:35","John.8:13","Romans.12:9","Mark.12:31","Romans.13:10","1Corinthians.13:4-8","1Corinthians.13:13","Ephesians.4:2","1Peter.4:8","1John.4:7","1John.4:18-19","John.15:13","Ephesians.5:25"]
    },
    {
      "id"=> "3",
      "days"=> ["Ephesians.5:33","Colossians.3:14","Proverbs.10:12","Proverbs.17:17","1John.3:16-18","1John.4:8","John.3:16","Psalm.18:1","Matthew.22:27-29","Proverbs.10:12","SongofSolomon.8:4-8","Matthew.6:24","Matthew.22:37-39","Matthew.23:6-8"]
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
      "days"=> ["Proverbs.18:10","Proverbs.3:5-6","Isaiah.41:10","John.14:27","John.16:33","Psalm.46:1-3","2Timothy.1:7","Psalm.16:8","Psalm.55:22","1Peter.5:7","Isaiah.26:3","Psalm.118:14-16","Psalm.119:114-115","Psalm.119:25","Psalm.119:50","Psalm.119:71","Psalm.120:1"]
    },
    {
      "id"=>"8",
      "days"=> ["James.1:19-20","Proverbs.29:11","James.1:20","Proverbs.19:11","Ecclesiastes.7:9","Proverbs.15:1","Proverbs.15:18","Colossians.3:8","James.4:1-2","Proverbs.16:32","Proverbs.22:24","Matthew.5:22","Psalm.37:8-9","Psalm.7:11","2Kings.11:9-10","2Kings.17:18","Proverbs.14:29"]
    },
    {
      "id"=>"9",
      "days"=> ["Philippians.4:13","Psalm.37:4","Psalm.1:1-3","Proverbs.16:3","1.Kings.2:3","Matthew.16:26-27","Luke.16:10-11","Romans.12:2","Isaiah.41:10","Philippians.4:6","Deuteronomy.8:18","Jeremiah.17:7"]
    },
    {
      "id"=>"10",
      "days"=> ["1Corinthians.6:19-20", "1Corinthians.3:16-17","Romans.12:1-2","1Corinthians.10:31","1Timothy.4:8","1Timothy.5:23","Matthew.6:22-23","1Corinthians.15:44","Philippians.1:20","1Corinthians.12:27","Psalm.100:3","Romans.12:4"]
    },
    {
      "id"=>"11",
      "days"=> ["Matthew.6:21","Malachi.3:10","Ecclesiastes.5:10","Romans.13:8","Psalm.37:16-17","Proverbs.13:11","Hebrews.13:5","Matthew.19:21","Proverbs.17:16","Matthew.6:24","Luke.3:14","Exodus.22:25","1Timothy.6:10","Deuteronomy.23:19","Matthew.21:12-13","1Timothy.6:17-19","Luke.12:33","Deuteronomy.15:7","Matthew.6:1-4","Mark.12:41-44","Proverbs.10:4","Revelation.3:17","Luke.16:13","Matthew.13:22","2Chronicles.1:11-12","1Peter.5:2-3","1Samuel.2:7","Proverbs.3:9"]
    },
    {
      "id"=>"12",
      "days"=> ["1Timothy.6:17","Matthew.6:8","Psalm.56:6","Psalm.23:4","Exodus.34:21"]
    },
    {
      "id"=>"13",
      "days"=> ["Galatians.6:9","3John.1:8","Ecclesiastes.11:1-2","1Timothy.6:18","Proverbs.21:5","Deuteronomy.8:18","Matthew.6:24"]
    },
    {
      "id"=>"100",
      "days"=> ["Genesis.1-2", "Genesis.3-5", "Genesis.6-8", "Genesis.9-11", "Genesis.12-14", "Genesis.15-17", "Genesis.18-19", "Genesis.20-22", "Genesis.23-24", "Genesis.25-26", "Genesis.27-28", "Genesis.29-30", "Genesis.31-32", "Genesis.33-35", "Genesis.36-37", "Genesis.38-40", "Genesis.41", "Genesis.42-43", "Genesis.44-45", "Genesis.46-48", "Genesis.49-50"]
    },
    {
      "id"=>"101",
      "days"=> ["John.1:1-28", "John.1:29-51", "John.2:1-25" , "John.3:1-21", "John.3:22-36" , "John.4:1-26" , "John.4:27-54", "John.5:1-30", "John.5:31-6:14", "John.6:15-50" , "John.6:60-7:9", "John.7:10-44", "John.7:45-8:20", "John.8:21-47", "John.8:48-9:12", "John.9:13-41", "John.10:1-21", "John.10:22-11:16", "John.11:17-44", "John.11:45-12:19", "John.12:20-50", "John.13:1-30", "John.13:31-14:18", "John.14:19-15:17", "John.15:18-16:24", "John.16:25-17:19", "John.17:20-18:11", "John.18:12-40", "John.19:1-30", "John.19:31-20:18", "John.20:19-21:25"]
    },
    {
      "id"=>"102",
      "days"=> ["Luke.1", "Luke.2", "Luke.3", "Luke.4", "Luke.5", "Luke.6", "Luke.7", "Luke.8", "Luke.9", "Luke.10", "Luke.11", "Luke.12", "Luke.13", "Luke.14", "Luke.15", "Luke.16", "Luke.17", "Luke.18", "Luke.19", "Luke.20", "Luke.21", "Luke.22", "Luke.23", "Luke.24"]
    },
    {
      "id"=>"103",
      "days"=> ["Matthew.1", "Matthew.2", "Matthew.3", "Matthew.4", "Matthew.5", "Matthew.6", "Matthew.7", "Matthew.8", "Matthew.9", "Matthew.10", "Matthew.11", "Matthew.12", "Matthew.13", "Matthew.14", "Matthew.15", "Matthew.16", "Matthew.17", "Matthew.18", "Matthew.19", "Matthew.20", "Matthew.21", "Matthew.22", "Matthew.23", "Matthew.24", "Matthew.25", "Matthew.26", "Matthew.27"]
    },
    {
      "id"=>"104",
      "days"=> ["Mark.1", "Mark.2", "Mark.3", "Mark.4", "Mark.5", "Mark.6", "Mark.7", "Mark.8", "Mark.9", "Mark.10", "Mark.11", "Mark.12", "Mark.13", "Mark.14", "Mark.15", "Mark.16"]
    },
  ]

  def verses
    passage = READING_PLAN.select{ |p| p['id'] == params[:plan_id] }.first["days"][params[:day].to_i - 1]

    if (cache = Cache.find_by_passage(passage)).present?
      text = cache.text
    else
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

      if Cache.find_by_passage(passage).nil?
        Cache.create({passage: passage, text: text})
      end
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
    all = Usage.select(:user_name).distinct.pluck(:user_name).compact
    old = Usage.select(:user_name).where('created_at < ?', 3.days.ago).distinct.pluck(:user_name).compact
    @new_users = all - old

    @usage_by_date = Usage.where("user_name not like 'Warren' and user_name not like 'Kelvin' and user_name not like 'Jaime Thomas' and created_at > ?", 2.weeks.ago).group('date(created_at)').order('date(created_at) desc').count('distinct(user_name)')

    order_sql = case params['sort']
    when 'users' then 'user_name, created_at desc'
    when 'time' then 'created_at desc'
    else 'DATE(created_at) desc, user_name, created_at desc'
    end
    @users = Usage.all.where("user_name not like 'Warren' and user_name not like 'Kelvin' and user_name not like 'Jaime Thomas' and created_at > ?", 2.weeks.ago).order(order_sql)

    sql = "select user_name, count(*), max(created_at), min(created_at), max(created_at) - min(created_at) as duration from usages group by user_name order by max(created_at) desc, min(created_at) desc"
    @overall_duration = ActiveRecord::Base.connection.execute(sql)

    sql = "select user_name, count(*), max(created_at), min(created_at), max(created_at) - min(created_at) as duration from usages where usage_type like 'ANSWERED_WRONG' or usage_type like 'ANSWERED_CORRECT' group by user_name order by max(created_at) desc, min(created_at) desc"
    @played_count = ActiveRecord::Base.connection.execute(sql)
  end

  def users_count
    users = Usage.where("usage_type not like 'OPEN' and user_name is not null and created_at > ?", 1.week.ago).group('user_name').order('count(*) desc').count
    render text: "<div id=user-header>#{users.length} weekly active Bible app users.  Thank you for being one of them!</div>"
  end

  def users
    users = Usage.where("usage_type not like 'OPEN' and user_name is not null and created_at > ?", 1.week.ago).group('user_name').order('count(*) desc').count
    output = "<li id=user-header>#{users.length} WEEKLY ACTIVE USERS:</li>";
    users.each do |user|
      output << "<li>#{user[0]}</li>"
    end
    render text: "<ul>#{output}</ul>"
  end

  def memorized_verses
    memorized = []
    Usage.where("usage_type in ('ANSWERED_CORRECT') and user_id like ?", params['user_id']).order('plan_id, day').each do |plan|
      memorized << [plan.plan_id, plan.day]
    end
    render text: memorized.to_json
  end

  def memorized_verses_with_count
    #Usage.where("usage_type like 'ANSWERED_CORRECT' and user_id like ?", "gVrc4bCuf969OS7FTqyi").select('count(*) as count, plan_id, day').group('plan_id, day').order('plan_id').all.first.count
    memorized = []
    Usage.where("usage_type like 'ANSWERED_CORRECT' and user_id like ?", params['user_id']).select('count(*) as count, plan_id, day').group('plan_id, day').order('plan_id').each do |plan|
      #puts "#{plan.count} - #{plan.plan_id} - #{plan.day}"
      passage = READING_PLAN.select{ |p| p['id'] == plan.plan_id.to_s }.first["days"][plan.day.to_i - 1]
      memorized << [plan.plan_id, plan.day, passage, plan.count]
    end
    render text: memorized.to_json
  end

  def delete_users
    Usage.delete_all("user_name like 'kelvin' or user_name like 'Kelvin'")
    render text: 'ok'
  end

  def memorized_stats
    #Usage.where('created_at > ?', DateTime.now.in_time_zone("Pacific Time (US & Canada)").beginning_of_day).length
    # "date(convert_tz(created_at,'UTC','Pacific Time (US & Canada)'))"
    #select (created_at AT TIME ZONE 'US/Pacific')::date, user_name, count(*) from usages where (usage_type like 'ANSWERED_WRONG' or usage_type like 'ANSWERED_CORRECT') and created_at > NOW() - INTERVAL '13 days' group by user_id, user_name, (created_at AT TIME ZONE 'US/Pacific')::date order by timezone desc, count(*) desc;
    #select user_name, (created_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Pacific')::date, count(*) from usages where (usage_type like 'ANSWERED_WRONG' or usage_type like 'ANSWERED_CORRECT') and created_at > NOW() - INTERVAL '8 days' group by user_id, user_name, (created_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Pacific')::date order by timezone desc, count(*) desc;

    output = {}
    output['today'] = DateTime.now.in_time_zone("Pacific Time (US & Canada)").to_date.strftime('%F')


    if Rails.env == 'production'
      time_sql = "(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Pacific')::date"
      time_ago_sql = "created_at > NOW() - INTERVAL '13 days'"
    else
      time_sql = "DATE(created_at)"
    end


    if Rails.env == 'production'
      sql = "select #{time_sql}, user_name, count(*) from usages where (usage_type like 'ANSWERED_WRONG' or usage_type like 'ANSWERED_CORRECT') and #{time_ago_sql} group by user_id, user_name, #{time_sql} order by timezone desc, count(*) desc;"
    else
      sql = "select #{time_sql}, user_name, count(*) from usages where (usage_type like 'ANSWERED_WRONG' or usage_type like 'ANSWERED_CORRECT') group by user_id, user_name, #{time_sql} order by #{time_sql} desc, count(*) desc;"
    end

    stats = ActiveRecord::Base.connection.execute(sql)
    stats.each do |row|
      output['stats-active'] = [] if output['stats-active'].nil?
      output['stats-active'] << { 'date' => row['timezone'], 'user_name' => row['user_name'], 'count' => row['count'] }
    end

    if Rails.env == 'production'
      sql = "select #{time_sql}, user_name, count(*) from usages where usage_type like 'ANSWERED_CORRECT' and #{time_ago_sql} group by user_id, user_name, #{time_sql} order by timezone desc, count(*) desc;"
    else
      sql = "select #{time_sql}, user_name, count(*) from usages where usage_type like 'ANSWERED_CORRECT' group by user_id, user_name, #{time_sql} order by #{time_sql} desc, count(*) desc;"
    end

    stats = ActiveRecord::Base.connection.execute(sql)
    stats.each do |row|
      output['stats-correct'] = [] if output['stats-correct'].nil?
      output['stats-correct'] << { 'date' => row['timezone'], 'user_name' => row['user_name'], 'count' => row['count'] }
    end

    render text: output.to_json
  end

  def memorized_stats_weekly
    output = {}
    current_week_of = DateTime.now.in_time_zone("Pacific Time (US & Canada)").to_date.beginning_of_week(start_day = :saturday).strftime('%F')

    if Rails.env == 'production'
      time_sql = "(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Pacific')::date"
    else
      time_sql = "DATE(created_at)"
    end

    if Rails.env == 'production'
      sql = "select #{time_sql}, user_name, count(*) from usages where user_name not like 'homepage' and usage_type like 'ANSWERED_CORRECT' group by user_name, #{time_sql} order by timezone desc, count(*) desc;"

      stats = ActiveRecord::Base.connection.execute(sql)
      stats.each do |row|
        week_of = Date.strptime(row['timezone'], '%Y-%m-%d').beginning_of_week(start_day = :saturday).strftime('%F')
        output[week_of] = {} if output[week_of].nil?
        count = 0
        if output[week_of][row['user_name']]
          count = output[week_of][row['user_name']]
        end
        output[week_of][row['user_name']] = count + row['count'].to_i
      end
    else
      sql = "select #{time_sql} as timezone, user_name, count(*) from usages where usage_type like 'ANSWERED_CORRECT' group by user_name, #{time_sql} order by #{time_sql} desc, count(*) desc;"

      stats = ActiveRecord::Base.connection.execute(sql)
      stats.each do |row|
        week_of = row[0].beginning_of_week(start_day = :saturday).strftime('%F')
        output[week_of] = {} if output[week_of].nil?
        count = 0
        if output[week_of][row[1]]
          count = output[week_of][row[1]]
        end
        output[week_of][row[1]] = count + row[2].to_i
      end
    end

    output_sorted = {}
    output_sorted['weeks'] = []
    output.each do |key, value|
      if key == current_week_of
        output_sorted[key] =  value.sort_by { |name, age| age }.reverse!
      else
        output_sorted[key] = value.sort_by { |name, age| age }.reverse.take(1).flatten
      end
      output_sorted['weeks'] << key
    end
    output_sorted['current_week_of'] = current_week_of
    
    render text: output_sorted.to_json
  end



  def bg_rating
    @rating = Usage.where("usage_type like 'RATE-BG' and created_at > '2015-07-01 02:09:45'").select('details').group('details').order('count(*) desc').count

    output = {}
    output['low'] = []
    output['high'] = []
    output['low-count'] = []
    output['high-count'] = []
    output['total'] = 0

    @rating.each do |rate|
      rating, bg = rate[0].split('-')
      if ['1'].include? rating
        output['low'] << bg
        output['low-count'] << rate[1]
      elsif ['5'].include? rating
        output['high'] << bg
        output['high-count'] << rate[1]
      end
      output['total'] += rate[1]
    end

    render text: output.to_json
  end

  def menu
    render text: %q(
    <ul>
      <li>
        <p><strong>What's New</strong></p>
        <p>7-20-2015: You can now remove a plan from your plans.
        <p>7-13-2015: You can now add books of Bible to your plans.  The books are broken down into verses that you can read on a daily basis as you open new tabs.</p>
      </li>
      <li>
        <p><strong>Support Our Work</strong></p>
        <p>Help spread God's words to more people!</p>
        <p><a id='share' href='http://www.bibleverseapp.com' target='_blank'>Share It</a></p>
        <p>Connect with us!</p>
        <p><a id='fb' href='https://www.facebook.com/pages/My-Daily-Bible-Verse/1643317539236200' target='_blank'>Like our Facebook page</a></p>
        <p>Encouragement</p>
        <p><a id='rate' href='https://chrome.google.com/webstore/detail/daily-bible-verse/jogajkcgclkfedbhdcopmpmeeophkkji/reviews' target='_blank'>Rate it or leave a feedback</a></p>
      </li>
    </ul>
    )
  end

  def startup_data
    menu_html = %q(
    <ul>
      <li>
        <p><strong>What's New</strong></p>
        <p>7-20-2015: You can now remove a plan from your plans.
        <p>7-13-2015: You can now add books of Bible to your plans.  The books are broken down into verses that you can read on a daily basis as you open new tabs.</p>
      </li>
      <li>
        <p><strong>Support My Work</strong></p>
        <p>Help spread God's words to more people!</p>
        <p><a id='share' href='http://www.bibleverseapp.com' target='_blank'>Share It</a></p>
        <p>Connect with me!</p>
        <p><a id='fb' href='https://www.facebook.com/pages/My-Daily-Bible-Verse/1643317539236200' target='_blank'>Like the Facebook page</a></p>
        <p>Encourage me!</p>
        <p><a id='rate' href='https://chrome.google.com/webstore/detail/daily-bible-verse/jogajkcgclkfedbhdcopmpmeeophkkji/reviews' target='_blank'>Rate it or leave a feedback</a></p>
      </li>
    </ul>
    )
    site_of_the_week = 'http://faithreel.com/'

    output = {}
    output['menu'] = menu_html
    output['site_of_the_week'] = site_of_the_week

    render text: output.to_json
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

  #def memorize_users
  #  user_count = Usage.where("usage_type like 'ANSWERED_WRONG' or usage_type like 'ANSWERED_CORRECT' and created_at > ?", 2.days.ago).group('user_name').order('count(*) desc').count
  #  render text: user_count.to_json
  #end

  #def usage_stats
  #  viewed_count = Usage.where(usage_type: 'VIEWED-LIKE').count
  #  played_count = Usage.where(usage_type:  ['ANSWERED_WRONG','ANSWERED_WRONG']).count
  #  output = {}
  #  output['viewed-count'] = viewed_count
  #  output['played-count'] = played_count
  #  render text: output.to_json
  #end

end
