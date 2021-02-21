require './lib/riddle.rb'

require 'pry'
require 'sinatra'
require 'sinatra/reloader'

also_reload 'lib/**/*.rb'

get '/' do
  erb :scene_open
end

get '/first' do
  @riddle = Riddle.new('Stop! What... is your name?', 'Sir Lancelot of Camelot')
  if params[:answer]
    if @riddle.correct? params[:answer]
      erb :to_second
    else
      erb :wrong
    end
  else 
    erb :first
  end
end

get '/second' do
  @riddle = Riddle.new('What... is your quest?', 'To seek the Holy Grail')
  if params[:answer]
    if @riddle.correct? params[:answer]
      erb :to_third
    else
      erb :wrong
    end
  else
    erb :second
  end
end

get '/third' do
  @riddle = Riddle.new('What... is your favorite color?', 'Blue')
  if params[:answer]
    if @riddle.correct? params[:answer]
      erb :all_correct
    else
      erb :wrong
    end
  else
    erb :third
  end
end

get '/riddles' do 
  @riddles = Riddle.all

  erb :riddles
end

get '/riddles/new' do
  erb :new_riddle
end

post '/riddles' do
  Riddle.new(params[:riddle_text], params[:riddle_answer])
    .save
  @riddles = Riddle.all
  erb :riddles
end

