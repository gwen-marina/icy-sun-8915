class EmployeesController < ApplicationController

  def show 
    @employee = Employee.find(params[:id])
  end

  def update 
    @employee = Employee.find(params[:id])
    @employee.tickets.create(subject: params[:subject], age: params[:age])
    redirect_to "/employees/#{@employee.id}"
  end
end