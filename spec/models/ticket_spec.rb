require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'relationships' do
    it { should have_many :employee_tickets }
  end

  describe 'validations' do
    it { should validate_presence_of :subject }
    it { should validate_presence_of :age}
  end

  describe 'class methods' do
    it 'shows employee tickets from oldest to youngest' do
      dep3 = Department.create!(name: "Marketing", floor: "seventh")
      emp3 = dep3.employees.create!(name: "Nick Jones", level: 5)
      tic1 = emp3.tickets.create!(subject: "Make ad", age: 3)
      tic2 = emp3.tickets.create!(subject: "Make Instagram post", age: 4)
      tic3 = emp3.tickets.create!(subject: "Edit ad", age: 2)
   
      tickets = Ticket.order_by_oldest 
    
      expect(tickets[0]).to eq(tic2)
      expect(tickets[1]).to eq(tic1)
    end

     it 'shows the oldest ticket' do
      dep3 = Department.create!(name: "Marketing", floor: "seventh")
      emp3 = dep3.employees.create!(name: "Nick Jones", level: 5)
      tic1 = emp3.tickets.create!(subject: "Make ad", age: 3)
      tic2 = emp3.tickets.create!(subject: "Make Instagram post", age: 4)
      tic3 = emp3.tickets.create!(subject: "Edit ad", age: 2)
   
      tickets = Ticket.oldest_ticket
    
      expect(tickets).to eq(tic2)
    end
  end
end