class Song < Entity    
  field :title,     type: String
  field :artist,    type: String
  field :createdAt, type: Time
  
  def to_s
    "Song: #{self.title} by #{self.artist}"
  end
end