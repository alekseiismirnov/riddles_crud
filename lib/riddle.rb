class Riddle 
  attr_reader :text

  def initialize(text, answer)
    @text = text
    @answer = answer
  end

  def correct? answer
    return @answer == answer
  end
end
