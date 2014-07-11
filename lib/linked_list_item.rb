class LinkedListItem
  include Comparable

  attr_accessor :payload, :next_item

  def initialize(value)
    @payload = value
    @next_item = nil
  end

  def <(li)
    convert_payload_for_comparison(@payload) < convert_payload_for_comparison(li.payload)
  end

  def >(li)
    convert_payload_for_comparison(@payload) > convert_payload_for_comparison(li.payload)
  end

  def ==(li)
    convert_payload_for_comparison(@payload) == convert_payload_for_comparison(li.payload)
  end

  def ===(li)
    self.object_id == li.object_id
  end

  def convert_payload_for_comparison(payload)
    payload.to_s
  end

  def next_item=(next_obj)
    if next_obj.object_id == self.object_id
      raise ArgumentError
    else
      @next_item = next_obj
    end
  end

  def last?
    if @next_item
      false
    else
      true
    end
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

  def print_each(accumulator="")
    accumulator += if last?
      @payload.to_s + " "
    else
      @payload.to_s + ", "
    end

    if last?
      return accumulator
    end

    @next_item.print_each(accumulator)
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
end
