class Array
  def each!
    yield(shift) while count.positive?
  end
end
