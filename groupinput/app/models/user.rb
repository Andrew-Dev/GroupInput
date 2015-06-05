class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :audiences

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  def fullName
    return "#{self.first_name} #{self.last_name}"
  end
end