class CreateEmployeeTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_tickets do |t|
      t.integer :employee_id
      t.integer :ticket_id

      t.timestamps
    end
  end
end
