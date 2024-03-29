class Message < ActiveRecord::Base
	attr_accessible :convo, :to
	belongs_to :user
  belongs_to :to, class_name: "User"

	default_scope order: 'messages.created_at DESC'

	validates :user_id, presence: true
  VALID_MESSAGE = /\A!/i
  validates :convo, presence: true, format: { with: VALID_MESSAGE }

	before_save :send_message

private

  def self.from_users_inbox(user)
    "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id = :user_id OR to_id = :user_id", user_id: user.id)
  end

	MESSAGE_REGEX = /\A!([^\s]*)/
  def send_message
    if match = MESSAGE_REGEX.match(convo)
      user = User.find_by_regex(match[1])
      self.to ||= user
		end
	end
end
