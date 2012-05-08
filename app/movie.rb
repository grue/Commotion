class Movie < Entity    
  field :title,       type: String
  field :total_gross, type: Float
  field :createdAt,   type: Time
  
  def to_s
    "Movie: #{self.title} earned #{self.total_gross}"
  end
end
