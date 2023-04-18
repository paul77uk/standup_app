class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  self.implicit_order_column = 'created_at' # new setting here

  delegate :render, to: :ApplicationController
  delegate :dom_id, to: 'ActionView::RecordIdentifier'
end
