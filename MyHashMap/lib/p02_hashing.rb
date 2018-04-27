require 'pry'
require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    string = []
    self.each do |el| 
      hashed = el.hash 
      if hashed < 0 
        hashed *= -1
      end
      string << hashed
    end 
    string.join.to_i.hash
  end
end

class String
  def hash
    self.chars.map { |char| char.ord }.join.to_i.hash 
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    return 0.hash if self.empty?
    final_hash = nil
    self.each do |k, v| 
      combined_hash = (k.hash.to_s + v.hash.to_s).to_i
      final_hash = final_hash.nil? ? combined_hash : final_hash ^ combined_hash
    end 
    final_hash
  end
end
