require 'rails_helper'

RSpec.describe "Emplyoee Show Page", type: :feature do 

  it "lists an employee's name and department" do 
    dep1 = Department.create!(name: "Human Resources", floor: "fifth")
    dep2 = Department.create!(name: "Payroll", floor: "Basement")
    dep3 = Department.create!(name: "Marketing", floor: "seventh")

    emp1 = dep1.employees.create!(name: "Jane Doe", level: 1)
    emp2 = dep2.employees.create!(name: "Doe John", level: 4)
    emp3 = dep3.employees.create!(name: "Nick Jones", level: 5)

    tic1 = emp3.tickets.create!(subject: "Make ad", age: 3)
    tic2 = emp3.tickets.create!(subject: "Make Instagram post", age: 4)
    tic3 = emp3.tickets.create!(subject: "Edit ad", age: 2)

    visit "/employees/#{emp3.id}"

    expect(page).to have_content('Nick Jones')
    expect(page).to have_content(5)
    expect(page).to_not have_content("Doe John")
  end

  it "can list all an employee's tickets from oldest to youngest" do 
    dep3 = Department.create!(name: "Marketing", floor: "seventh")
    emp3 = dep3.employees.create!(name: "Nick Jones", level: 5)

    tic1 = emp3.tickets.create!(subject: "Make ad", age: 3)
    tic2 = emp3.tickets.create!(subject: "Make Instagram post", age: 4)
    tic3 = emp3.tickets.create!(subject: "Edit ad", age: 2)

    visit "/employees/#{emp3.id}"
   
    expect(page).to have_content("Make ad")
    expect(page).to have_content("Make Instagram post")
    expect(page).to have_content("Edit ad")
  end

  it "can list the oldest ticket assigned to the employee separately" do 
    dep3 = Department.create!(name: "Marketing", floor: "seventh")
    emp3 = dep3.employees.create!(name: "Nick Jones", level: 5)

    tic1 = emp3.tickets.create!(subject: "Make ad", age: 3)
    tic2 = emp3.tickets.create!(subject: "Make Instagram post", age: 4)
    tic3 = emp3.tickets.create!(subject: "Edit ad", age: 2)
   
    visit "/employees/#{emp3.id}"
 
    expect(page).to have_content("Make Instagram post")
  end

  it "can add a ticket to an employee" do 
    dep1 = Department.create!(name: "Human Resources", floor: "fifth")
    emp1 = dep1.employees.create!(name: "Jane Doe", level: 1)

    dep2 = Department.create!(name: "Payroll", floor: "Basement")
    emp2 = dep2.employees.create!(name: "Doe John", level: 4)

    tic1 = emp1.tickets.create!(subject: "Create new hire folders", age: 2)
    tic2 = emp1.tickets.create!(subject: "Review employee complaints", age: 3)
    tic3 = emp2.tickets.create!(subject: "Go over weekly survey results", age: 1)
  
    visit "/employees/#{emp1.id}"

    fill_in 'ticket_id', with: "#{tic3.id}"
    click_button 'Submit'

    expect(current_path).to eq("/employees/#{emp2.id}")
    expect(page).to have_content("Go over weekly survey results")
  end
end


