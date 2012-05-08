class Song < Entity    
  field :title,     type: String
  field :artist,    type: String
  field :createdAt, type: Time
  
  def to_s
    "Song: #{self.title} earned #{self.artist}"
  end
end