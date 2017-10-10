class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, dependent: :destroy
  has_many :collaborators
  has_many :wiki_collaborations, through: :collaborators, source: :wiki

  enum role: [:standard, :premium, :admin]

  after_initialize :default_to_standard

  private
  def default_to_standard
    self.role = 'standard' if self.role.nil?
  end

end
