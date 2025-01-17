module Comparable
  ##
  #  call-seq:
  #    obj.clamp(min, max) ->  obj
  #    obj.clamp(range)    ->  obj
  #
  # In <code>(min, max)</code> form, returns _min_ if _obj_
  # <code><=></code> _min_ is less than zero, _max_ if _obj_
  # <code><=></code> _max_ is greater than zero, and _obj_
  # otherwise.
  #
  #    12.clamp(0, 100)         #=> 12
  #    523.clamp(0, 100)        #=> 100
  #    -3.123.clamp(0, 100)     #=> 0
  #
  #    'd'.clamp('a', 'f')      #=> 'd'
  #    'z'.clamp('a', 'f')      #=> 'f'
  #
  # In <code>(range)</code> form, returns _range.begin_ if _obj_
  # <code><=></code> _range.begin_ is less than zero, _range.end_
  # if _obj_ <code><=></code> _range.end_ is greater than zero, and
  # _obj_ otherwise.
  #
  #    12.clamp(0..100)         #=> 12
  #    523.clamp(0..100)        #=> 100
  #    -3.123.clamp(0..100)     #=> 0
  #
  #    'd'.clamp('a'..'f')      #=> 'd'
  #    'z'.clamp('a'..'f')      #=> 'f'
  #
  # If _range.begin_ is +nil+, it is considered smaller than _obj_,
  # and if _range.end_ is +nil+, it is considered greater than
  # _obj_.
  #
  #    -20.clamp(0..)           #=> 0
  #    523.clamp(..100)         #=> 100
  #
  # When _range.end_ is excluded and not +nil+, an exception is
  # raised.
  #
  #     100.clamp(0...100)       # ArgumentError
  #
  def clamp(min, max=nil)
    if max.nil?
      if min.kind_of?(Range)
        max = min.begin
        if max.nil?
          max = self
        elsif min.exclude_end?
          raise ArgumentError, "cannot clamp with an exclusive range"
        end
        min = min.end
        if min.nil?
          min = self
        end
      else
        raise TypeError, "wrong argument type #{min.class}"
      end
    end
    if (min <=> max) > 0
      raise ArgumentError, "min argument must be smaller than max argument"
    end
    c = self <=> min
    if c == 0
      return self
    elsif c < 0
      return min
    end
    c = self <=> max
    if c > 0
      return max
    else
      return self
    end
  end
end
