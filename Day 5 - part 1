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

update_lines.each do |update_line|
  invalid = false
  update_line.each_cons(2) do |update|
    if update[0].in?(queue[update[1]] || [])
      invalid = true
      break
    end
  end
  next if invalid

  p update_line
  p update_line.length
  p (update_line.length/2)
  p update_line[update_line.length/2]

  sum += update_line[update_line.length/2]
end
