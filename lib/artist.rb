class Artist
    extend Concerns::Findable
    attr_accessor :name, :songs, :genres
    @@all = []
    
    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def add_song(song)
        song.artist = self
    end

    def songs
        Song.all.select do |song| song.artist == self
        end
    end
    
    def songs
        @songs
     end

     def add_song(song)
        if !song.artist
        song.artist= self
        end
        if !self.songs.include?(song)
        self.songs << song
        end
    end

    def genres
        self.songs.map do |song|
            song.genre
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

    def genres
        self.songs.collect{|song| song.genre}.uniq
    end
end