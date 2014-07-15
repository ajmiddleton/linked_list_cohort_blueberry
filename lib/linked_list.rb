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
    unless @size == 0
      get(@size -1)
    end
  end

  def to_s
    @size == 0 ? "| |" : "| " + @head.each_to_s + "|"
  end

  def [](index)
    get(index)
  end

  def []=(index, new_payload)
    @head.set(index, new_payload)
  end

  def get_item(index)
    raise IndexError if index < 0 || index > @size
    current_item = @head
    index.times do
      raise IndexError if current_item.nil?
      current_item = current_item.next_item
    end
    current_item
  end

  def swap(left_index, right_index)
    if right_index <= left_index
      return
    end

    diff = right_index - left_index

    left_prev = get_item(left_index -1) unless left_index == 0
    left = get_item(left_index)
    left_next = left.next_item

    right_prev = get_item(right_index -1)
    right = get_item(right_index)

    left_index == 0 ? @head = right : left_prev.next_item = right
    right_prev.next_item = left if diff > 1
    left.next_item = right.next_item
    diff > 1 ? right.next_item = left_next : right.next_item = left

  end

  def sort!
    quicksort(0, @size-1)
  end

  def quicksort(left_index, right_index)
    if left_index < right_index
      par = partition(left_index, right_index)
      quicksort(left_index, par-1)
      quicksort(par+1, right_index)
    end
  end

  def partition(left_index, right_index)
    pivot_index = ((right_index - left_index) / 2) + left_index
    pivot_value = get_item(pivot_index)
    swap(pivot_index, right_index)
    store_index = left_index

    for i in left_index...right_index
      if get_item(i) <= pivot_value
        swap(store_index, i)
        store_index += 1
      end
    end
    swap(store_index, right_index)
    store_index
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

  def sorted?
    return true if @size < 2
    @head.check_sorted
  end
end
