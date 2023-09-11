# https://leetcode.com/problems/implement-trie-prefix-tree/
# [Medium]
#
# Anything that makes me implement a whole-ass class is annoying!!!
# I haven't seen tries since ECE345 so I had to take a peek at wiki
# to make sure it's what I remember it being, and to see if there
# were any tips on making a non-shitty one. I gave up halfway down
# the article and just went with this implementation that I mean,
# beats 92.42% of other rubes on time but eats shit on memory (only
# beats 7.57% for memory, maybe bc of how I implemented TrieNode..

# Helper thingy courtesy of yours truly and not provided by LC!!
# TBH idk if there was a more efficient way of doing this, I mean
# probably but I see a trie as a bunch of circles and lines and
# I will use some sort of linked-list-esque thing.
class TrieNode
  attr_accessor :val, :children, :terminal
  def initialize(val)
    @val = val
    @children = {}
    @terminal = false
  end
end

class Trie
  attr_accessor :root
  def initialize()
    @root = TrieNode.new(nil)
  end


=begin
  :type word: String
  :rtype: Void
=end
  def insert(word)
    curr = @root

    word.each_char do |c|
      unless curr.children[c]
        curr.children[c] = TrieNode.new(c)
      end
      curr = curr.children[c]
    end

    curr.terminal = true
  end


=begin
  :type word: String
  :rtype: Boolean
=end
  def search(word)
    curr = @root

    word.each_char do |c|
      curr = curr.children[c]
      return false if curr.nil?
    end

    curr.terminal
  end


=begin
  :type prefix: String
  :rtype: Boolean
=end
  def starts_with(prefix)
    curr = @root

    prefix.each_char do |c|
      curr = curr.children[c]
      return false if curr.nil?
    end

    true
  end
end

# Your Trie object will be instantiated and called as such:
# obj = Trie.new()
# obj.insert(word)
# param_2 = obj.search(word)
# param_3 = obj.starts_with(prefix)

# Back to me - alright so this tracks with the LC editorial, even tho
# I didn't look too closely at the code itself yayayay. So idgaf abt
# the space, it's a LGTM for moi
