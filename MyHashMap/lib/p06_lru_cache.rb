require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

require 'pry'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count 
  end

  def get(key)
    if @map.include?(key)
      update_node!(@map.delete(key))
    else 
      eject! if count == @max 
      calc!(key)
    end 
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    node = @store.append(node,key)
    @map.set(node, key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    node.remove # this removes from link list only, does not clear memory until function ends  
    append(node.key, node.val)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    node = @store.first.remove
    @map.delete(node)
    # binding.pry
  end
end
