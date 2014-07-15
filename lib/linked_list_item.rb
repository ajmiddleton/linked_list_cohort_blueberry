class LinkedListItem
  include Comparable

  attr_accessor :payload, :next_item

  def initialize(value)
    @payload = value
    @next_item = nil
  end

  def <=>(other_item)
    if self.payload.class == other_item.payload.class
      self.payload <=> other_item.payload
    else
      precedence = [ Fixnum, String, Symbol ]
      left = precedence.index(self.payload.class)
      right = precedence.index(other_item.payload.class)
      left <=> right
    end
  end

  def ===(other_item)
    self.equal? other_item
  end

  def next_item=(next_obj)
    raise ArgumentError if next_obj === self
    @next_item = next_obj
  end

  def last?
    @next_item ? false : true
  end

  def append(lli)
    if self.last?
      @next_item = lli
      return
    else
      @next_item.append(lli)
    end
  end

  def fetch(index)
    if index == 0
      return @payload
    end
    @next_item.fetch(index - 1)
  end

  def set(index, new_payload)
    if index == 0
      @payload = new_payload
      return
    end
    @next_item.set(index-1, new_payload)
  end

  def each_to_s(accumulator="")
    accumulator += last? ? @payload.to_s + " " : @payload.to_s + ", "

    if last?
      return accumulator
    end

    @next_item.each_to_s(accumulator)
  end

  def destroy(index, prev=nil)
    if index == 0
      prev.next_item = @next_item
      return
    end
    @next_item.destroy(index-1, self)
  end

  def find(payload, index=0)
    return index if payload == @payload
    return nil if last?
    @next_item.find(payload, index+1)
  end

  def check_sorted(bool=true)
    if last?
      return bool
    end
    if @next_item < self
      return false
    end
    @next_item.check_sorted
  end
end
