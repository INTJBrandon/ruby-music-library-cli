class Song
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        if genre != nil
            self.genre = genre
        end
        if artist != nil
            self.artist = artist
        end
    end

    def self.all
        @@all
    end

    def self.new_from_filename(filename)
        arr = filename.split(/\ - |\./)
        song_name = arr[1]
        artist = arr[0]
        genre = arr[2]
        artist = Artist.find_or_create_by_name(artist)
        genre = Genre.find_or_create_by_name(genre)
        self.new(song_name, artist, genre)
      end

      def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        if genre.songs.find{|song| song == self}
        else
        genre.songs << self
        end
    end

    def save
        @@all << self
    end
    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        instance = self.new(name)
        instance.save
        instance
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        self.all << song
    end
end