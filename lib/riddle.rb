class Riddle 
  attr_reader :text, :answer, :id

  @@riddles = {}
  @@total_rows = 0 
  @@current_id =nil

  def initialize(text, answer, id = nil)
    @text = text
    @answer = answer
    @id = id || @@total_rows += 1
  end

  def self.all
    @@riddles.values
  end

  # There is no way to make a random riddle task
  # but keep the state of the Riddle class.
  # We'll return riddle with the .random
  # every time the same, untill we call .randomize or delete this riddle
  def self.random
    return @@riddles[@@current_id]
  end

  def self.randomize
    @@current_id = @@riddles.keys.sample unless @@riddles == {}
  end
  # ---------- 

  def self.clear
    @@total_rows = 0
    @@riddles = {}
  end

  def self.find id
    @@riddles[id]
  end

  def save 
    @@riddles[id] = Riddle.new(self.text, self.answer, id)
  end

  def correct? answer
    return @answer == answer
  end

  def == another_riddle
    (self.text == another_riddle.text) and (self.answer == another_riddle.answer)
  end

  def update updates={}
    @text = updates[:text] or @text
    @answer = updates[:answer] or @answer 
  end

  def delete
    @@riddles.delete @id
  end

  def hint
    if @answer.length >= 4
      return "#{@answer[0,3]}..."
    else
      return 'Really?'
    end
  end
end
