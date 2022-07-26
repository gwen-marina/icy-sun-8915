class Ticket < ApplicationRecord
  has_many :employee_tickets
  has_many :employees, through: :employee_tickets

  validates_presence_of :subject
  validates_presence_of :age

  def self.order_by_oldest 
    order(age: :desc)
  end

  def self.oldest_ticket 
    order_by_oldest.first
  end
end