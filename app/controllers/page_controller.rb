require 'rexml/document'

class PageController < ApplicationController
  include REXML
  include ActionView::Helpers::DateHelper

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
      "id"=>"14",
      "days"=> ["Philippians.4:6","John.3:16","Romans.12:2","Galatians.2:20","Romans.6:23","Romans.12:1","Ephesians.2:8","Philippians.4:7","Romans.8:28","Psalms.1:1","Romans.5:8","Proverbs.3:5","Hebrews.12:1","Romans.3:23","Genesis.1:1","Proverbs.3:6","Philippians.4:8","Psalms.119:11","Psalms.1:2","Galatians.5:22","2.Timothy.3:16","Philippians.4:13","Psalms.23:1","Ephesians.2:9","John.1:1","Psalms.1:3","2.Corinthians.5:17","Psalms.23:6","Psalms.23:4","Psalms.23:2","Psalms.23:3","1.John.1:9","Psalms.23:5","James.1:2","Psalms.1:6","Joshua.1:8","Psalms.1:5","Psalms.1:4","Jeremiah.29:11","2.Timothy.3:17","James.1:3","Galatians.5:23","Hebrews.4:12","Romans.8:1","John.3:17","Hebrews.11:1","James.1:4","James.1:5","John.1:2","Matthew.5:16"]
    },
    {
      "id"=>"15",
      "days"=> ["Proverbs.18:22", "Colossians.3:18-19", "Proverbs.31:10", "1Corinthians.7:2", "Proverbs.16:9", "Genesis.2:18"]
    },
    {
      "id"=>"16",
      "days"=> ["Ephesians.3:16-17","Mark.11:24","Hebrews.11:1","Romans.15:13","James.1:6","1Peter.1:8-9","Hebrews.11:6","James.1:3","John.11:40","John.11:25-26","Romans.14:1","1Timothy.6:11","1Corinthians.13:2","1John.5:4","Psalm.119:30","John.6:35","Romans.10:10","Mark.10:52","Hebrews.11:11","Romans.1:17","Galatians.3:26-27","John.3:16","John.6:29","Mark.16:16","1John.5:13","Acts.16:31","2Corinthians.5:7","2Thessalonians.1:3","Hebrews.12:2","John.7:38","Galatians.2:20","1John.5:5","Romans.12:3","Philippians.1:29","1Timothy.6:6","Galatians.3:22","Romans.10:9","1Timothy.4:12","1Corinthians.13:13","Romans.3:21-22","John.1:12","Romans.1:16","1Thessalonians.4:14","Romans.14:4","Ephesians.2:8-9","Galatians.2:15-16","1Corinthians.15:1-2","Galatians.5:6","Romans.10:4","John.3:18"]
    },
    {
      "id"=>"17",
      "days"=> ["Isaiah.41:10","Isaiah.40:31","Psalm.73:26","Isaiah.40:29","Philippians.4:13","2Timothy.1:7","2Thessalonians.3:3","Psalm.59:16","Jeremiah.32:17","1Chronicles.16:11","Psalm.18:1-2","Ephesians.3:20-21","Habakkuk.3:19","Psalm.18:31","Job.37:23","2Corinthians.12:10"]
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
    {
      "id"=>"105",
      "days"=> ["Acts.1", "Acts.2", "Acts.3", "Acts.4", "Acts.5", "Acts.6", "Acts.7", "Acts.8", "Acts.9", "Acts.10", "Acts.11", "Acts.12", "Acts.13", "Acts.14", "Acts.15", "Acts.16", "Acts.17", "Acts.18", "Acts.19", "Acts.20", "Acts.21", "Acts.22", "Acts.23", "Acts.24", "Acts.25", "Acts.26", "Acts.27", "Acts.28"]
    },
    {
      "id"=>"106",
      "days"=> ["psalm.1", "psalm.2", "psalm.3", "psalm.4", "psalm.5", "psalm.6", "psalm.7", "psalm.8", "psalm.9", "psalm.10", "psalm.11", "psalm.12", "psalm.13", "psalm.14", "psalm.15", "psalm.16", "psalm.17", "psalm.18", "psalm.19", "psalm.20", "psalm.21", "psalm.22", "psalm.23", "psalm.24", "psalm.25", "psalm.26", "psalm.27", "psalm.28", "psalm.29", "psalm.30","psalm.31", "psalm.32", "psalm.33", "psalm.34", "psalm.35", "psalm.36", "psalm.37", "psalm.38", "psalm.39", "psalm.40", "psalm.41", "psalm.42", "psalm.43", "psalm.44", "psalm.45", "psalm.46", "psalm.47", "psalm.48", "psalm.49", "psalm.50", "psalm.51", "psalm.52", "psalm.53", "psalm.54", "psalm.55", "psalm.56", "psalm.57", "psalm.58", "psalm.59", "psalm.60", "psalm.61", "psalm.62", "psalm.63", "psalm.64", "psalm.65", "psalm.66", "psalm.67", "psalm.68", "psalm.69", "psalm.70", "psalm.71", "psalm.72", "psalm.73", "psalm.74", "psalm.75", "psalm.76", "psalm.77", "psalm.78", "psalm.79", "psalm.80", "psalm.81", "psalm.82", "psalm.83", "psalm.84", "psalm.85", "psalm.86", "psalm.87", "psalm.88", "psalm.89", "psalm.90", "psalm.91", "psalm.92", "psalm.93", "psalm.94", "psalm.95", "psalm.96", "psalm.97", "psalm.98", "psalm.99", "psalm.100", "psalm.101", "psalm.102", "psalm.103", "psalm.104", "psalm.105", "psalm.106", "psalm.107", "psalm.108", "psalm.109", "psalm.110", "psalm.111", "psalm.112", "psalm.113", "psalm.114", "psalm.115", "psalm.116", "psalm.117", "psalm.118", "psalm.119", "psalm.120", "psalm.121", "psalm.122", "psalm.123", "psalm.124", "psalm.125", "psalm.126", "psalm.127", "psalm.128", "psalm.129", "psalm.130", "psalm.131", "psalm.132", "psalm.133", "psalm.134", "psalm.135", "psalm.136", "psalm.137", "psalm.138", "psalm.139", "psalm.140", "psalm.141", "psalm.142", "psalm.143", "psalm.144", "psalm.145", "psalm.146", "psalm.147", "psalm.148", "psalm.149",  "psalm.150"]
    },
    {
      "id"=>"107",
      "days"=> ["Romans.1:1-15", "Romans.1:16-32", "Romans.2:1-11", "Romans.2:12-29", "Romans.3:1-8", "Romans.3:9-20", "Romans.3:21-31", "Romans.4:1-12", "Romans.4:13-25", "Romans.5:1-20", "Romans.6:1-14", "Romans.6:15-23", "Romans.7:1-6", "Romans.7:7-25", "Romans.8:1-11", "Romans.8:12-30", "Romans.8:31-39", "Romans.9:1-18", "Romans.9:19-33", "Romans.10:1-21", "Romans.11:1-10", "Romans.11:11-36", "Romans.12:1-8", "Romans.12:9-21", "Romans.13:1-7", "Romans.13:8-14", "Romans.14:1-12", "Romans.14:13-23", "Romans.15:1-13", "Romans.15:14-33", "Romans.16:1-27"]
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

    #log_usage('READ')

    render text: text
  end

  def favorite_param
    if params[:user_id].present? && params[:user_name].present? && params[:plan_id].present? && params[:day].present?
      [params[:user_id], params[:user_name], params[:plan_id], params[:day]]
    else
      nil
    end
  end

  def is_favorite
    is_fav = false
    if favorite_param
      is_fav = Favorite.where('user_id = ? and user_name = ? and plan_id = ? and day = ?', *favorite_param).present?
    end
    render_verse_favorite_data(['is_fav', is_fav])
  end

  def add_favorite
    if favorite_param
      Favorite.where('user_id = ? and user_name = ? and plan_id = ? and day = ?', *favorite_param).delete_all
      Favorite.create!(
          user_id: params[:user_id],
          user_name: params[:user_name],
          plan_id: params[:plan_id],
          day: params[:day],
      )
      render_verse_favorite_data(['is_fav', true])
    end
  end

  def remove_favorite
    if favorite_param
      Favorite.where('user_id = ? and user_name = ? and plan_id = ? and day = ?', *favorite_param).delete_all
      render_verse_favorite_data(['is_fav', false])
    end
  end

  def render_verse_favorite_data(addition_data = nil)
    output = {}
    output['count'] = verse_favorite_count
    output['users'] = verse_favorite_user_info
    output['all'] = user_all_favorites
    if addition_data
      output[addition_data[0]] = addition_data[1]
    end
    render text: output.to_json
  end

  # Depricate this in mid Feb
  def verse_favorite_count
    count = 0
    if params[:plan_id].present? && params[:day].present?
      count = Favorite.where('plan_id = ? and day = ?', params[:plan_id].to_i, params[:day].to_i).count
    end
    count
  end

  def verse_favorite_user_info
    user_info = []
    if params[:plan_id].present? && params[:day].present?
      Favorite.where('plan_id = ? and day = ? and user_id != ?', params[:plan_id].to_i, params[:day].to_i, params[:user_id]).order(created_at: :desc).each do |f|
        user_info << f.user_name
      end
    end
    user_info
  end

  # Return favorited verses of this user
  def user_all_favorites
    output = []
    if params[:user_id].present? && params[:user_name].present?
      Favorite.where('user_id = ? and user_name = ?', params[:user_id], params[:user_name]).each do |f|
        output << [f.plan_id, f.day]
      end
    end
    output
  end

  def all_favorites
    render text: user_all_favorites.to_json
  end

  def add_gratitude
    gratitude_count = nil
    if params[:user_id].present? && params[:user_name].present? && params[:text].present?
      Gratitude.create!(
          user_id: params[:user_id],
          user_name: params[:user_name],
          text: params[:text]
      )
      gratitude_count = Gratitude.where('user_id = ?', params[:user_id]).count
    end
    render text: gratitude_count
  end

  def get_gratitudes
    graitudes = []
    Gratitude.order('created_at desc').all.each do |g|
      graitudes << { user_name: g.user_name, text: g.text, time: g.created_at }
    end
    #graitudes.shuffle.to_json
    graitudes.to_json
  end

  def get_recent_favorites
    favorites = []
    Favorite.where('created_at > ?', 3.days.ago).order('created_at desc').all.each do |f|
      favorites << { user_name: f.user_name, plan_id: f.plan_id, day: f.day, time: f.created_at }
    end
    favorites.shuffle.to_json
  end

  def finished
    #log_usage('FINISHED')
    render nothing: true, status: 200
  end

  def answered
    #log_usage('ANSWER')
    render nothing: true, status: 200
  end

  def usage
    log_usage(params[:usage_type])
    render nothing: true, status: 200
  end

  def gratitudes
    @gratitudes = Gratitude.order('created_at desc').all
  end

  def report
    all = Usage.select(:user_name).distinct.pluck(:user_name).compact
    old = Usage.select(:user_name).where('created_at < ?', 3.days.ago).distinct.pluck(:user_name).compact
    @new_users = all - old

    @usage_by_date = Usage.where("user_name not like 'Warren' and user_name not like 'Kelvin' and user_name not like 'Jaime Thomas' and created_at > ?", 1.weeks.ago).group('date(created_at)').order('date(created_at) desc').count('distinct(user_name)')

    order_sql = case params['sort']
    when 'users' then 'user_name, created_at desc'
    when 'time' then 'created_at desc'
    else 'DATE(created_at) desc, user_name, created_at desc'
    end
    @users = Usage.all.where("user_name not like 'Warren' and user_name not like 'Kelvin' and user_name not like 'Jaime Thomas' and created_at > ?", 1.weeks.ago).order(order_sql)

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

  def get_activities
    @activities = []
    Favorite.where('user_id != ?', params['user_id']).order('created_at desc').limit(30).all.each do |f|
      passage = READING_PLAN.select{ |p| p['id'] == f.plan_id.to_s }.first["days"][f.day - 1]
      if (cache = Cache.find_by_passage(passage)).present?
        text = cache.text
      end
      @activities << { type: 'favorite', user_name: f.user_name, plan_id: f.plan_id, day: f.day, text: text, time: time_ago_in_words(f.created_at) }
    end

    @activities.to_json
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

  # Deprecated
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
        <p><strong>If you like this app:</strong></p>
        <p>Like the <a id='fb' href='https://www.facebook.com/pages/My-Daily-Bible-Verse/1643317539236200' target='_blank'>Facebook page</a></p>
        <p>Rate or leave feedback at the <a id='rate' href='https://chrome.google.com/webstore/detail/daily-bible-verse/jogajkcgclkfedbhdcopmpmeeophkkji/reviews' target='_blank'>Chrome App Store</a></p>
        <p><strong>To Remove this app:</strong></p>
        <p>On your browser, click the menu (the 3 lines icon).  Select More tools > Extensions. On the extension you want to remove, click Remove from Chrome.</p>
      </li>
    </ul>
    )
    site_of_the_week = 'http://faithreel.com/'

    output = {}
    output['menu'] = menu_html
    output['site_of_the_week'] = site_of_the_week
    output['activities'] = get_activities
    output['favorites'] = get_recent_favorites
    output['your-gratitudes-count'] = Gratitude.where('user_id = ?', params[:user_id]).count
    output['gratitudes-data'] = Gratitude.where('user_id = ?', params[:user_id]).order('created_at asc')

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
