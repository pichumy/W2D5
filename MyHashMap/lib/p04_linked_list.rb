class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = self.next 
    @next.prev = self.prev
  end
end

class LinkedList
  include Enumerable
  
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail 
    @tail.prev = @head  
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return @head.next unless empty? 
    nil
  end

  def last
    return @tail.prev unless empty?  
    nil
  end

  def empty?
    @head.next == @tail 
  end

  def get(key)
    self.each do |node| 
      if node.key == key 
        return node.val
      end 
    end 
    nil 
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key 
    end 
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    @tail.prev.next = node 
    node.prev = @tail.prev
    node.next = @tail 
    @tail.prev = node 
  end

  def update(key, val)
    self.each do |node|
      if node.key == key 
        node.val = val 
      end 
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key 
        node.remove
        return 
      end 
    end 
    nil
  end

  def each
    current_node = @head.next 
    until current_node.next == nil 
      yield(current_node)
      current_node = current_node.next 
    end 
    self 
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
