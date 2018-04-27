require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    if @count == num_buckets / 2 + 1  
      resize!
    end
    unless include?(key)
      self[key].push(key) 
      @count += 1 
    end 
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1 
    end 
  end

  private

  def [](num)
    @store[num.hash % num_buckets]# optional but useful; return the bucket corresponding to `num`
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
