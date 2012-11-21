require 'sinatra'
require 'mpd_client'

def make_client()
	client = MPDClient.new
	client.connect('localhost')
	return client
end

get '/' do
	mpd = make_client()
	@song = mpd.currentsong 
	@playlist = mpd.playlistinfo
	erb :main
end

get '/playpause' do
	mpd = make_client()
	if mpd.status['state'] == 'play'
		mpd.pause
	else
		mpd.play
	end
	redirect '/'
end

get '/play/:songid' do |songid|
	mpd = make_client()
	mpd.playid songid
	redirect '/'
end

get '/next' do
	mpd = make_client()
	mpd.next
	redirect '/'
end

get '/prev' do
	mpd = make_client()
	mpd.previous
	redirect '/'
end
