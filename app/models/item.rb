class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  belongs_to :merchant

  def self.find_item_by_name(name)
    self.where('name ILIKE ?', "%#{name}%").order(:name).first
  end
end 