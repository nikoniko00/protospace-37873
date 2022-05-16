class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name,                presence: true
  validates :profile,             presence: false
  validates :occupation,              presence: false
  validates :position,   presence: false 
  has_many :prototypes
  has_many :comments, dependent: :destroy
end
