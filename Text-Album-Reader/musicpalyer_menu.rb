require './input_functions'

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

Genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end

class Album
	attr_accessor :title, :artist, :genre, :tracks

	def initialize (title, artist, genre, tracks)
		@title = title
		@artist = artist
		@genre = genre
		@tracks = tracks
	end
end

def read_track (music_file)
	name = music_file.gets()
	location = music_file.gets()
	Track.new(name, location)
end

def read_tracks (music_file)
	tracks = Array.new()
	count = music_file.gets().to_i
i = 0
	while (count > i) do
		track = read_track(music_file)
		tracks << track
		i += 1
	end
	tracks
end 

def print_track (track)
	puts('Track title is: ' + track.name)
	puts('Track file location is: ' + track.location)
end

def print_tracks tracks

	index = 0
	while (index < tracks.length)
		print_track(tracks[index])
		index += 1
	end
end

def read_album music_file
	
	artist = music_file.gets()
	title = music_file.gets()
	genre = music_file.gets().to_i
	tracks = read_tracks(music_file)
	Album.new(title, artist, genre, tracks)
	
end

def read_albums music_file
	albums = Array.new()
	count = music_file.gets().to_i
i = 0
	while (count > i) do
		album = read_album(music_file)
		albums << album
		i += 1
	end
	albums
end 



def print_album album
	puts""
	puts 'Album Information is:'
	puts 'Title is ' + album.title
	puts 'Artist is ' + album.artist
	puts('Genre is ' + Genre_names[album.genre])
	print_tracks(album.tracks)
end

def print_albums albums
	puts "Print Album Menu"
	puts "1 - Display all albums"
	puts "2 - Display albums via genre"
	puts "3 - Main Menu"
	printmenu = read_integer ("enter a selection")
	
	case printmenu
	when 1
		index = 0
		while (index < albums.length)
			print_album(albums[index])
			index += 1
			puts""
		end	
	when 2
		puts '- Genres -'
		puts '1 - Pop'
		puts '2 - Classic'
		puts '3 - Jazz'
		puts '4 - Rock'
		displaygenre = read_integer ("Choose a genre")
		index = 0
		while (index < albums.length)
			if albums[index].genre == displaygenre then
				print_album(albums[index])
			end
			index += 1
			puts""
			
		end	
	when 3
		main
	end

end

def update_album(albums)
	upalbum = read_integer "Enter album number"
	
	puts "update album menu"
	puts "1 - change title"
	puts "2 - change genre"
	puts "3 - return to main menu"
	menuselection = read_integer "Choose an option"
	case menuselection
	when 1
		newtitle = read_string ("new title: ")
		albums[upalbum].title = newtitle
		print_album(albums[upalbum])
	when 2
		newgenre = read_integer("new genre: ")
		albums[upalbum].genre = newgenre
		print_album(albums[upalbum])
	when 3
		main
	end
end

def play_album(albums)
	albumplay = read_integer "Enter album number"
	trackplay = read_integer "Enter track number"
	
	puts "Now playing: " + albums[albumplay].tracks[trackplay].name + " from the album: " + albums[albumplay].title

end

def main
	finshed = false
	begin 
		puts ""
		puts "Welcome to Music Player"
		puts "1 - Read in albums"
		puts "2 - Display albums"
		puts "3 - Play an track"
		puts "4 - Update an album"
		puts "5 - Exit"
		menuselection = read_integer ("Enter menu selection")
		case menuselection
		when 1
			fname = read_string ("Enter in file name: ")
			music_file = File.new(fname, "r")
				albums = read_albums(music_file)
				album = read_album(music_file)
		when 2
			print_albums(albums)
		when 3
			play_album(albums)
		when 4
			update_album(albums)
		when 5
			finshed = true	
		end
	end until finshed
end

main