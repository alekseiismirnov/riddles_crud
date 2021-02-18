class Riddle 
  attr_reader :text, :answer, :id

  @@riddles = {}
  @@total_rows = 0 

  def self.all
    @@riddles.values
  end

  def initialize(text, answer, id = nil)
    @text = text
    @answer = answer
    @id = id
  end

  def save 
    id = self.id || @@total_rows += 1
    @@riddles[id] = Riddle.new(self.text, self.answer, id)
  end

  def correct? answer
    return @answer == answer
  end

  def == another_riddle
    (self.text == another_riddle.text) and (self.answer == another_riddle.answer)
  end
end

