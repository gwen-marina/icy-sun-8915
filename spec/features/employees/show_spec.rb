require 'rails_helper'

# As a user,
# When I visit the employee show page,
# I do not see any tickets listed that 
# are not assigned to the employee
# and I see a form to add a ticket to this movie
# When I fill in the form with the id of a ticket 
# that already exists in the database
# and I click submit
# Then I am redirected back to that employees show page
# and i see the ticket's subject now listed

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

    tic1 = emp1.tickets.create!(subject: "Create new hire folders", age: 2)
    tic2 = emp1.tickets.create!(subject: "Review employee complaints", age: 3)
    tic3 = emp1.tickets.create!(subject: "Go over weekly survey results", age: 1)
    # tic4 = Ticket.create!(subject: "Send out weekly survey", age: 1)

    visit "/employees/#{emp1.id}"

    fill_in 'Subject', with: 'Send out weekly survey'
    fill_in 'Age', with: 1
    click_button 'Add ticket to employee'

    expect(current_path).to eq("/employees/#{emp1.id}")
    expect(page).to have_content('Send out weekly survey')
  end
end

