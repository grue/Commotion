class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    Movie.create do |movie|
      movie.title = "Iron Man"
      movie.total_gross = 100000000
      movie.createdAt = Time.now
    end
    
    puts Movie.all
    puts Movie.find_by_title("Iron Man")
    
    Song.create do |song|
      song.title = "Ruby Baby"
      song.artist = "Bjork"
      song.createdAt = Time.now
    end
    
    puts Song.all
    puts Song.find_by_title("Ruby Baby")
    puts Song.find_by_artist("Bjork")
    
    return true
  end
end

