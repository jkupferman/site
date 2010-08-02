class Presenter < ActiveRecord::Base
  has_many :presentations
  has_many :videos, :through => :presentations

  belongs_to :user

  cattr_reader :per_page

  validates_uniqueness_of :first_name, :scope => :last_name

  @@per_page = 24

  def display_name
    aka_name.nil? ? "#{first_name} #{last_name}" : aka_name
  end
end
