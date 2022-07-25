class EmployeesController < ApplicationController

  def show 
    @employee = Employee.find(params[:id])
  end

  def update 
    @employee = Employee.find(params[:id])
    ticket = Ticket.find_by(subject: params[:subject], age: params[:age])
    if !ticket
      @employee.tickets.create(subject: params[:subject], age: params[:age])
    end
      redirect_to "/employees/#{@employee.id}"
  end
end