class AddPaypalColumnsToTransactions < ActiveRecord::Migration
  def change
  	add_column :transactions, :transaction_subject, :string
  	add_column :transactions, :payment_date, :datetime
  	add_column :transactions, :txn_type, :string
  	add_column :transactions, :subscr_id, :string
  	add_column :transactions, :last_name, :string
  	add_column :transactions, :residence_country, :string
  	add_column :transactions, :item_name, :string
  	add_column :transactions, :payment_gross, :string
  	add_column :transactions, :mc_currency, :string
  	add_column :transactions, :business, :string
  	add_column :transactions, :payment_type, :string
  	add_column :transactions, :protection_eligibility, :string
  	add_column :transactions, :verify_sign, :string
  	add_column :transactions, :payer_status, :string
  	add_column :transactions, :test_ipn, :string
  	add_column :transactions, :payer_email, :string
  	add_column :transactions, :txn_id, :string
  	add_column :transactions, :receiver_email, :string
  	add_column :transactions, :first_name, :string
  	add_column :transactions, :invoice, :string
  	add_column :transactions, :payer_id, :string
  	add_column :transactions, :receiver_id, :string
  	add_column :transactions, :payment_status, :string
  	add_column :transactions, :payment_fee, :string
  	add_column :transactions, :mc_fee, :string
  	add_column :transactions, :mc_gross, :string
  	add_column :transactions, :charset, :string
  	add_column :transactions, :notify_version, :string
  	add_column :transactions, :ipn_track_id, :string
  	add_column :transactions, :auth, :string
  	add_column :transactions, :mc_amount3, :string
  	add_column :transactions, :period3, :string
  	add_column :transactions, :subscr_date, :string
  	add_column :transactions, :recur_times, :string
  	add_column :transactions, :reattempt, :string
  	add_column :transactions, :recurring, :integer
  	add_column :transactions, :amount3, :string
  	
  end
end
