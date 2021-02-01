class Genre
    extend Concerns::Findable
    attr_accessor :name
    @@all = []
    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def add_song(song)
        song.genre = self
    end

    def songs
        Song.all.select do |song| song.genre == self
        end
    end
    
    def save
        @@all << self
    end
    def self.destroy_all
        @@all.clear
    end

    def songs
        @songs
    end

    def self.create(name)
        instance = self.new(name)
        instance.save
        instance
    end

    def artists
        self.songs.collect{|song| song.artist}.uniq
    end
end