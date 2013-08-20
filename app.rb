require 'echonest-ruby-api'

class EchoToy < Sinatra::Base
	configure :development do
		require 'better_errors'
  	use BetterErrors::Middleware
	end

	require 'multi_json'

	get '/' do
		erb :index
	end

	post '/process' do
		song = Echonest::Song.new(ENV['ECHONEST_KEY'])
    @results = song.search(:combined => params['file'][:filename], :song_type => 'studio').shuffle!
  	
		erb :_results, :layout => false
	end 
end

class Hash
  def shuffle
    Hash[self.to_a.sample(self.length)]
  end

  def shuffle!
    self.replace(self.shuffle)
  end
end

