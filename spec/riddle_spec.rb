require 'rspec'
require 'pry'

require 'riddle'

describe '#Riddle' do
  before :each do
    @riddle_text = "Answer 'yes'"
    @riddle_answer = "yes"

    @riddle = Riddle.new(@riddle_text, @riddle_answer)
  end

  describe "#text" do
    it 'returns text of the riddle' do
      expect(@riddle.text).to eq @riddle_text
    end
  end

  describe "#answer?" do
    it 'returns `true` if right answer is given' do
      expect(@riddle.correct? @riddle_answer).to eq true
    end

    it 'returns `false` on wrong answer' do
      expect(@riddle.correct? 'no').to eq false
    end
  end
end
