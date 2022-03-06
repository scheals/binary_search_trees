# frozen_string_literal: true

# This module handles objects that can have their values compared.
module Comparable
  def more_than(comparable, second_comparable)
    comparable.value > second_comparable.value
  end

  def more_or_equal(comparable, second_comparable)
    comparable.value >= second_comparable.value
  end

  def less_or_equal(comparable, second_comparable)
    comparable.value <= second_comparable.value
  end

  def less_than(comparable, second_comparable)
    comparable.value < second_comparable.value
  end
end
