require 'rails_helper'

RSpec.describe "Department Index Page", type: :feature do

  it "lists department's name, floor, and all employees of department" do
    dep1 = Department.create!(name: "Human Resources", floor: "fifth")
    dep2 = Department.create!(name: "Payroll", floor: "Basement")
    dep3 = Department.create!(name: "Marketing", floor: "seventh")

    emp1 = dep1.employees.create!(name: "Jane Doe", level: 1)
    emp2 = dep2.employees.create!(name: "Doe John", level: 4)
    emp3 = dep3.employees.create!(name: "Nick Jones", level: 5)

    visit '/departments'

    within "#departments-#{dep1.id}" do
      expect(page).to have_content("Human Resources")
      expect(page).to have_content("fifth")
      expect(page).to have_content("Jane Doe")
    end

    within "#departments-#{dep2.id}" do
      expect(page).to have_content("Payroll")
      expect(page).to have_content("Basement")
      expect(page).to have_content("Doe John")
    end

    within "#departments-#{dep3.id}" do
      expect(page).to have_content("Marketing")
      expect(page).to have_content("seventh")
      expect(page).to have_content("Nick Jones")
    end 
  end
end