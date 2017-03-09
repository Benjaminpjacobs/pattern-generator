class PatternGenerator
  attr_accessor :pattern_arr, :imap

  MIN_VAL = "0"
  MAX_VAL = "9"
  PATTERNELEMENTS = {
    "."=> %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z), 
    "#"=>(MIN_VAL..MAX_VAL).to_a
  }

  def initialize
    @pattern_arr = []
    @imap = []
  end

  def verify(input, pattern)
    verify = true
    pattern.split('').zip(input.split('')).each do |compare|
      if compare[0] != compare[1] && !PATTERNELEMENTS[compare[0]] .include?(compare[1])
        verify = false 
        break    
      else
        next    
      end
    end
    verify
  end

  def total_available(pattern)
    avail_array = pattern.split('').map do |item|
      case item
      when "." 
        item = 26
      when "#"
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
    ia = @pattern_arr.reverse.map{ |item| item.is_a?(Array) ? item.count : item }
    
    ia.each do |item|
      if item.is_a?(String)
        imap << 'lit'
        next
      elsif iteration == 0
        imap << nil
        next
      elsif iteration < item
        imap << iteration
      else
        imap << iteration % item
      end
      iteration = iteration / item
    end
    imap.reverse!
  end

  def pattern_logic(x)
    return x[0] if x[1] == "lit"
    return x[0][0] if x[1].nil?
    return x[0][x[1]]
  end

  def generate(iteration, pattern)
    create_enumerated_array(pattern)
    iterations_per_enumerator(iteration)
    @pattern_arr.zip(imap).map(&method(:pattern_logic)).join
  end  
  
end