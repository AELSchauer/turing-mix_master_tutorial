class Artist < ApplicationRecord
  validates :name, :image_path, presence: true
  validates :name,              uniqueness: true
  has_many  :songs

  EXCEPT_FIELDS = ["id", "created_at", "updated_at"]

  def input_attributes
    self.attributes.except(EXCEPT_FIELDS)
  end

  def input_values
    self.attributes.except(EXCEPT_FIELDS).values
  end

  def self.input_fields
    column_names.find_all { |column| EXCEPT_FIELDS.include?(column) == false }
  end

end
