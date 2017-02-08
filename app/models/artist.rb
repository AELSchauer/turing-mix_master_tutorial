class Artist < ApplicationRecord
  validates :name, :image_path, presence: true
  validates :name,              uniqueness: true

  EXCEPT_FIELDS = ["id", "created_at", "updated_at"]

  def input_attributes
    self.attributes.except(EXCEPT_FIELDS)
  end

  def input_values
    input_attributes.values
  end

  def self.input_fields
    Artist.column_names.find_all { |column| EXCEPT_FIELDS.include?(column) == false }
  end
end
