require './lib/riddle.rb'

require 'pry'
require 'sinatra'
require 'sinatra/reloader'

also_reload 'lib/**/*.rb'

get '/' do
  Riddle.new('Stop! What... is your name?', 'Sir Lancelot of Camelot').save
  Riddle.new('What... is your quest?', 'To seek the Holy Grail').save
  Riddle.new('What... is your favorite color?', 'Blue').save

  erb :scene_open
end

get '/first' do
  @riddle = Riddle.random 
  if params[:answer]
    if @riddle.correct? params[:answer]
      erb :to_second
    else
      erb :wrong
    end
  else 
    Riddle.randomize
    @riddle = Riddle.random
    erb :first
  end
end

get '/second' do
  @riddle = Riddle.random 
  if params[:answer]
    if @riddle.correct? params[:answer]
      erb :to_third
    else
      erb :wrong
    end
  else 
    Riddle.randomize
    @riddle = Riddle.random
    erb :second
  end
end

get '/third' do
  @riddle = Riddle.random
  if params[:answer]
    if @riddle.correct? params[:answer]
      erb :all_correct
    else
      erb :wrong
    end
  else
    Riddle.randomize
    @riddle = Riddle.random
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

get '/riddles/:id' do
  @riddle = Riddle.find params[:id].to_i
  erb :riddle_view
end

# individual riddle update form
get '/riddles/:id/edit' do
  @riddle = Riddle.find params[:id].to_i

  erb :riddle_edit
end

patch '/riddles/:id' do
  @riddle = Riddle.find params[:id].to_i
  @riddle.update(text: params[:riddle_text], answer: params[:riddle_answer])

  erb :riddle_view
end

delete '/riddles/:id' do
  riddle = Riddle.find params[:id].to_i
  riddle.delete

  @riddles = Riddle.all

  erb :riddles
end
