class Dataset < ActiveRecord::Base
  belongs_to :adt
  belongs_to :graph
end
