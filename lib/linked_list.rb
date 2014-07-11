require 'linked_list_item'

class LinkedList
  attr_accessor :head, :size

  def initialize(*seed)
    @head = nil
    @size = 0

    seed.each {|s| self.push(s) } if seed.size > 0
  end

  def push(payload)
    @size += 1
    lli = LinkedListItem.new(payload)
    @head ? @head.append(lli) : @head = lli
  end

  def get(index)
    raise IndexError if index < 0 || index > @size
    @head.fetch(index)
  end

  def last
    if @size == 0
      return nil
    else
      get(@size -1)
    end
  end

  def to_s
    @size == 0 ? "| |" : "| " + @head.print_each + "|"
  end

  def [](index)
    get(index)
  end

  def []=(index, new_payload)
    @head.set(index, new_payload)
  end

  def delete(index)
    raise IndexError if index < 0 || index > @size
    @size -= 1
    if index == 0
      @head = @head.next_item
      return
    end
    @head.destroy(index)
  end

  def index(payload)
    return nil if @size == 0
    @head.find(payload)
  end
end
