# file = File.open(Rails.root.join('tmp','printqueuesmall'))
file = File.open(Rails.root.join('tmp','printqueue'))

raw_queue = []
raw_updated = []

file.each do |line|
  raw_queue << line.gsub("\n", '') if line.include? '|'
  raw_updated << line.gsub("\n", '') if line.include? ','
end

queue = {}
raw_queue.each do |line|
  parts = line.split('|')
  queue[parts[0].to_i] ||= []
  queue[parts[0].to_i] << parts[1].to_i
end

update_lines = raw_updated.map { |line| line.split(',').map(&:to_i) }

sum = 0

invalid_update_lines = []

update_lines.each do |update_line|
  invalid = false
  update_line.each_cons(2) do |update|
    if update[0].in?(queue[update[1]] || [])
      invalid = true
      break
    end
  end
  if invalid
    invalid_update_lines << update_line
    next
  end

  sum += update_line[update_line.length/2]
end

corrected_update_lines = []

invalid_update_lines.each do |invalid_update_line|
  ranks = {}
  invalid_update_line.each do |update|
    ranks[update] ||= 0
    order = queue[update] || []
    ranks[update] += (order & (invalid_update_line - [update])).length
  end
  corrected_update_lines << Hash[ranks.sort_by {|_key, value| value}].keys.reverse
end

corrected_sum = 0

corrected_update_lines.each do |update_line|
  corrected_sum += update_line[update_line.length/2]
end
