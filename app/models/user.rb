class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :transactions
  has_many :commentaries
  has_many :market_studies
  has_many :general_market_studies
  validates_presence_of :agreed, :message => "? (You must be agreed to Terms & Conditions)", :on => :create 

	# def active_for_authentication?
	
	# 	super #&& account_active
	# end
      
   
 private    
	def password_required?
  		new_record? ? super : false
	end  

end
