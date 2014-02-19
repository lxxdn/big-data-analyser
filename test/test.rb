require 'btree'

tree = Btree.create(2)

tree[2] = 'foo value'


puts "key 2 has value: #{tree[2]}"
puts "BTree has #{tree.size} key-value pairs"