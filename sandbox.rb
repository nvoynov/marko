# inline @@todo

s0 = "sample @@todo sample"
s1 = "sample @@todo sample\n"
s2 = "@@todo sample"
s3 = "@@todo sample\n"

def sub(sample)
  pat = /.*@@todo.*/
  cap = /(.*)@@todo.*/
  return sample unless sample =~ pat
  m = sample.match(cap)
  # pp m
  m[1].strip + sample.gsub(pat, '')
end

pp sub(s0)
pp sub(s1)
pp sub(s2)
pp sub(s3)

def gsub(sample)
  pat = /.*@@todo.*/
  String.new(sample).tap{|str|
    str.scan(pat)
       .uniq
       .each{|sam| str.gsub!(sam, sub(sam))}
  }
end

sam = <<~EOF
  some big text with many @@todo
  @@todo sample
  line @@todo sample
  @@todo
EOF

pp gsub(sam)
