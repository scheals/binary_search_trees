# frozen_string_literal: true

# This module handles objects that can have their values compared.
module Comparable
  def >(other)
    value > other.value
  end

  def >=(other)
    value >= other.value
  end

  def <=(other)
    value <= other.value
  end

  def <(other)
    value < other.value
  end

  def ==(other)
    value == other.value
  end
end
