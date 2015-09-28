class Array
  def my_each(&blk)
    i=0
    while i < self.length
      blk.call(self[i])
      i+=1
    end
    self
  end

  def my_select(&blk)
    result=[]
    i=0
    while i < self.length
      result << self[i] if blk.call(self[i])
      i+=1
    end
    result
  end

  def my_reject(&blk)
    result=[]
    i=0
    while i < self.length
      result << self[i] unless blk.call(self[i])
      i+=1
    end
    result
  end

  def my_any?(&blk)
    my_each do |x|
      return true if blk.call(x)
    end
    false
  end

  def my_all?(&blk)
    my_each do |x|
      return false unless blk.call(x)
    end
    true
  end

  def my_flatten
    result = []
    my_each do |x|
      if x.class == Array
        result << x.my_flatten
      else
        result << x
      end
    end
    result
  end

  def my_zip(*others)
    result = []
    i = 0
    while i < self.length
      result << ( [self[i]] + others.map{ |other| other[i] } )
      i += 1
    end
    result
  end

  def my_rotate(num_times = 1)
    result = self.dup
    if num_times > 0
      num_times.times { result << result.shift }
    else
      (-num_times).times { result.unshift(result.pop)}
    end
    result
  end

  def my_join(sep = '')
    result = self[0].to_s.dup
    i = 1
    while i < self.length
      result << (sep + self[i].to_s)
      i += 1
    end
    result
  end

  def my_reverse
    result = []
    my_each { |x| result.unshift(x) }
    result
  end

end
