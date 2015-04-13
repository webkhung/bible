class Usage < ActiveRecord::Base
  #user_id
  #ip
  #plan_id
  #day
  #usage_type
  #created_at
  #updated_at

  def self.users
    #Usage.where("user_name is not null").group('user_name').maximum(:created_at)
    self.select(:user_name).distinct
  end

  def self.users_stats
    #self.where("usage_type = 'ANSWER' and user_name is not null").group('user_name').count
    #self.where("usage_type = 'ANSWER' and user_name is not null and created_at > ?", Time.zone.now.beginning_of_day).group('user_name').count
    self.where("user_name is not null").group('user_name').group('usage_type').order("user_name, FIELD(usage_type, 'READ', 'ANSWER', 'FINISHED')").count
  end

end
