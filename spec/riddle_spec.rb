require 'rspec'
require 'pry'

require 'riddle'

describe '#Riddle' do
  before :each do
    Riddle.clear

    @riddle_text = "Answer 'yes'"
    @riddle_answer = "yes"

    @riddle = Riddle.new(@riddle_text, @riddle_answer)
  end

  describe '.all' do
    it 'is empty at the beginning' do
      expect(Riddle.all).to eq []
    end
  end

  describe '.clear' do
    it 'removes all records from the store' do
      Riddle.clear
      expect(Riddle.all).to eq []
    end
  end

  describe '.find' do
    it 'doesn`t find not saved riddle' do
      expect(Riddle.find @riddle.id).to eq(nil)
    end

    it 'finds riddle in db by id' do
      @riddle.save
      expect(Riddle.find @riddle.id).to eq(@riddle)
    end
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

  describe '#==' do
    it 'true when text and answer are the same' do
      riddle = Riddle.new('1+1', '2')
      riddle2 = Riddle.new('1+1', '2')
      expect(riddle == riddle2).to eq(true)
    end 
  end

  describe '#save' do
    it 'saved riddles can be obtained by .all method' do
      riddle = Riddle.new('1+1', '2')
      riddle2 = Riddle.new('1+2', '3')
      riddle.save
      riddle2.save

      expect(Riddle.all).to eq [riddle, riddle2]
    end
  end

  describe '#update' do
    before :each do
      @riddle_text = "Answer 'yes'"
      @riddle_answer = "yes"

      @riddle = Riddle.new(@riddle_text, @riddle_answer)
    end

    it 'changes the text of the riddle' do
      @riddle.update(text: 'Such much?')
      expect(@riddle.text).to eq 'Such much?'
    end

    it 'changes the answer of the riddle' do
      @riddle.update(answer: 'How to whom')
      expect(@riddle.correct? 'How to whom').to eq true
    end

    it 'answer update invalidates the old answer of the riddle' do
      @riddle.update(answer: 'Such much?')
      expect(@riddle.correct? @riddle_answer).to eq false
    end
  end

  describe '#delete' do
    it 'removes record from the store' do
      Riddle.clear
      @riddle.save
      @riddle.delete
      expect(Riddle.all).to eq []
    end
  end

  describe '#hint' do
    it 'gives a kind of hint when answer is long enought' do
      expect(Riddle.new('Question', 'Long-long answer').hint).to eq 'Lon...'
    end

    it 'asks to think again when answer is short' do
      expect(Riddle.new('Question', 'Sho').hint).to eq 'Really?'
    end
  end

  describe '#hinted' do
    it 'is false, if no hint was given before' do
      expect(@riddle.hinted?).to eq false
    end

    it 'is true, if hint was given before' do
      @riddle.hint
      expect(@riddle.hinted?).to eq true
    end

    it 'is true, if hint was given more then one time' do
      2.times { @riddle.hint }
      expect(@riddle.hinted?).to eq true
    end
  end
end
