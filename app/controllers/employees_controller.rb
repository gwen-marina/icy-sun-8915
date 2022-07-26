class EmployeesController < ApplicationController

  def show 
    @employee = Employee.find(params[:id])
  end

  def update 
    ticket = Ticket.find(params[:ticket_id]) 
    employee = ticket.employees.first
    redirect_to "/employees/#{employee.id}"
  end
end