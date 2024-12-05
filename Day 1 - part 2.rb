# file = File.open(Rails.root.join('tmp','pairssmall'))
file = File.open(Rails.root.join('tmp','pairs'))

pairs = []
file.each do |line|
  pairs << line.gsub("\n",'').split(' ').map(&:to_i)
end

left_side = pairs.map(&:first).sort
right_side = pairs.map(&:last).sort

distance_sum = 0
left_side.each_with_index do |left, i|
  distance_sum += (right_side[i] - left).abs
end

p distance_sum

similarity_sum = 0
left_side.each do |left|
  similarity_sum += (left * right_side.count(left))
end

p similarity_sum
