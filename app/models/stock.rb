class Stock < ApplicationRecord
  belongs_to :company
  belongs_to :project, optional: true
end
