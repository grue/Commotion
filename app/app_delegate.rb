class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    Movie.create do |movie|
      movie.title = "Iron Man"
      movie.total_gross = 100000000
    end
    
    puts Movie.all
    puts Movie.find_by_title("Iron Man")
    
    Song.create do |song|
      song.title = "Ruby Baby"
      song.artist = "Bjork"
    end
    
    puts Song.all
    song = Song.find_by_title("Ruby Baby")
    song.title = "Ruby, Baby"
    song.save
    puts song
    
    song = Song.find_by_artist("Bjork")
    song.destroy
    
    return true
  end
end

