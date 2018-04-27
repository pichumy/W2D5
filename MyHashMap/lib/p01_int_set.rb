require 'byebug'
class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    validate!(num)
    store[num] = true 
  end

  def remove(num)
    store[num] = false if is_valid?(num)
  end

  def include?(num)
    store[num] if is_valid?(num)
  end

  private

  def is_valid?(num)
    num < @max  && num > 0 
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @max = num_buckets
  end

  def insert(num)
    self[num].push(num) 
  end
  
  def remove(num)
    idx = self[num].index(num)
    self[num].delete_at(idx)
  end

  def include?(num)
    self[num].include?(num)
  end 

  private

  def [](num)
    key = num % @max 
    @store[key]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    if @count == num_buckets / 2 + 1  
      resize!
    end
    unless include?(num)
      @count += 1 
      self[num].push(num) 
    end 
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    key = num % num_buckets
    @store[key]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets = @num_buckets * 2 
    old_store = @store.dup 
    @store = Array.new(@num_buckets) { Array.new }
    @count = 0
    old_store.each do |bucket|
      bucket.each do |el|
        self.insert(el)
      end 
    end 
    
  end
end
