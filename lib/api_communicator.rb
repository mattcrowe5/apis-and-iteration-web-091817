require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  movie_links = character_movies(character)
  movie_info(movie_links)
end



def parse_character_movies(films_hash)
  count = 0
  films_hash.each do |movie|
    count += 1
    puts "#{count} #{movie["title"]}"
  end
  # some iteration magic and puts out the movies in a nice list
end


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

def character_movies(character)
  output = []
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  results = character_hash["results"]
  results.each do |person|
    if person["name"].downcase == character
      output = person["films"]
    end
  end
  return output
end

def movie_info(output)
  filmArray = []
  output.each do |link|
    moviedata = RestClient.get(link)
    moviedata_hash = JSON.parse(moviedata)
    filmArray << moviedata_hash
  end
  return filmArray
end
