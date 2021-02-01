class MusicLibraryController
    attr_accessor :path
  
    def initialize(path = "./db/mp3s")
      @path = path
      MusicImporter.new(@path).import
    end
  
    def call
      puts "Welcome to your music library!"
      input = ""
      while input != "exit"
        puts("To list all of your songs, enter 'list songs'.")
        puts("To list all of the artists in your library, enter 'list artists'.")
        puts("To list all of the genres in your library, enter 'list genres'.")
        puts("To list all of the songs by a particular artist, enter 'list artist'.")
        puts("To list all of the songs of a particular genre, enter 'list genre'.")
        puts("To play a song, enter 'play song'.")
        puts("To quit, type 'exit'.")
        puts("What would you like to do?")
  
        input = gets.strip
        if input == "list songs"
          self.list_songs
        elsif input == "list artists"
          self.list_artists
        elsif input == "list genres"
          self.list_genres
        elsif input == "list artist"
          name = gets.strip
          self.list_songs_by_artist
        elsif input == "list genre"
          name = gets.strip
          self.list_songs_by_genre
        elsif input == "play song"
          self.play_song
        end
      end
    end

    def list_songs
        list = Song.all.sort_by{|song| song.name}
        list.each_with_index{|song, index| 
        puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end

    def list_artists
        list = Artist.all.sort_by{|artist| artist.name}
        list.each_with_index{|artist, index| 
        puts "#{index + 1}. #{artist.name}"}
    end

    def list_genres
        list = Genre.all.sort_by{|genre| genre.name}
        list.each_with_index{|genre, index| 
        puts "#{index + 1}. #{genre.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets
        if Artist.all.find{|artist| artist.name == input}
        artist = Artist.all.find{|artist| artist.name == input}
        songs = artist.songs.sort_by{|song| song.name}
        songs.each_with_index{|song, index| 
        puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets
        if Genre.all.find{|genre| genre.name == input}
        genre = Genre.all.find{|genre| genre.name == input}
        songs = genre.songs.sort_by{|song| song.name}
        songs.each_with_index{|song, index| 
        puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip
        number = input.to_i - 1
        list = Song.all.sort_by{|song| song.name}
        if list[number] && number > 1 && number < list.length + 1
            song = list[number].name
            artist = list[number].artist.name
            puts "Playing #{song} by #{artist}"
        end
    end
end

