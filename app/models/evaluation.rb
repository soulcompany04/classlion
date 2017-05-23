include ActionView::Helpers::DateHelper
class Evaluation < ApplicationRecord

  resourcify
  belongs_to :course
  belongs_to :user
  has_many :comments
  has_many :reports
  has_one :like

  # before_create :increase_user_point
  # before_destroy :decrease_user_point

  # validations
  validates :body, length: { minimum: 10 }, presence: true

  def time_ago
    #강평 작성 시간
    if (time_ago_in_words(self.created_at)) == "1분 이하"
      return '방금 전'
    elsif (time_ago_in_words(self.created_at)).last == '분' or (time_ago_in_words(self.created_at)).last == '간'
      return time_ago_in_words(self.created_at) + " 전"
    elsif (time_ago_in_words(self.created_at)).last == '일' and (time_ago_in_words(self.created_at)).chomp('일').to_i < 8
      return time_ago_in_words(self.created_at) + " 전"
    else
      return ActionController::Base.helpers.time_tag(self.created_at, :format=>'%Y년 %m월 %d일')
    end
  end

  private
  def increase_user_point
    user = current_user
    point = user.point + 200
    user.update_attribute(:point, point)
  end

  def decrease_user_point
    user = current_user
    point = user.point - 200
    user.update_attribute(:point, point)
  end
end
