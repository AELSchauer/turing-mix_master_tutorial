class Song < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: { scope: :artist_id }

  belongs_to :artist
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs


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
