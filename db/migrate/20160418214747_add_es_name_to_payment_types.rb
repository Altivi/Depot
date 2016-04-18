class AddEsNameToPaymentTypes < ActiveRecord::Migration
  def change
    add_column :payment_types, :es_name, :string
  end
end
