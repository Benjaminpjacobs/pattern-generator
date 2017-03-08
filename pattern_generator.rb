class PatternGenerator
  
  PATTERNELEMENTS = {"."=>["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"], "#"=>['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']}

  def verify(input, pattern)
    verify = true
    pattern.split('').zip(input.split('')).each do |compare|
      if compare[0] == compare[1] || PATTERNELEMENTS[compare[0]].include?(compare[1])
        next
      else
        verify = false 
        break       
      end
    end
    verify
  end

  def total_available(pattern)
    avail_array = pattern.split('').map do |item|
      if item == "." 
        item = 26
      elsif item == "#"
        item = 10
      else
        item = nil
      end
    end
    avail_array.compact.reverse.reduce(&:*)
   end

  def create_enumerated_array(pattern)
    @pattern_arr = pattern.split('')

    @pattern_arr.count(".").times do 
      @pattern_arr[@pattern_arr.find_index(".")] = ("A".."Z").to_a
    end
    
    @pattern_arr.count("#").times do
      @pattern_arr[@pattern_arr.find_index("#")] = ("0".."9").to_a
    end
  end

  def iterations_per_enumerator(iteration)
    @imap = []
    ia = @pattern_arr.reverse.map{|item| item.is_a?(Array) ? item.count : item}
    
    ia.each do |item|
      if item.is_a?(String)
        @imap << 'lit'
        next
      elsif iteration == 0
        @imap << nil
        next
      elsif iteration < item
        @imap << iteration
      else
        @imap << iteration % item
      end
      iteration = iteration / item
    end
    @imap.reverse!
  end

  def generate(iteration, pattern)
    create_enumerated_array(pattern)
    iterations_per_enumerator(iteration)
    @serial = @pattern_arr.zip(@imap).map! do |x|
      if x[1] == "lit"
        x[0]
      elsif x[1] == nil
       x[0][0]
      else
        x[0][x[1]]
      end
    end   
    @serial.join
  end  
  
end