module IntroToRuby
  # Make changes to the method `def string_slice` so it passes the test. Note:
  #
  # 1. `string_slice` method should take from 1 to 5 arguments.
  # 2. `string_slice` method raises ArgumentError if it is more than 5 arguments.
  # 3. `string_slice` method returns a sequential array of these strings sliced up until the third character.
  # 4. `string_slice` method raises IndexError if the string is less than 3 characters long.
  def string_slice
  end
end


# do not modify the code below
# it includes test case for the code above

require 'minitest/autorun'
require 'minitest/pride'

class TestDecoder < Minitest::Test
  include IntroToRuby

  def test_should_return_an_array_of_strings_sliced_to_third_characters
    input = %w(Mary had many little horses)
    expected_output = %w(Mar had man lit hor)
    assert_equal expected_output, string_slice(*input)
  end

  def test_should_work_for_input_with_three_words
    input = %w(Mary had many)
    expected_output = %w(Mar had man)
    assert_equal expected_output, string_slice(*input)
  end

  def test_should_raise_argument_error_if_more_than_three_words
    input = %w(Mary had hundreds and hundreds little horses)
    e = assert_raises ArgumentError do
      string_slice(*input)
    end
    assert_equal "More than 5 arguments not supported", e.message
  end

  def test_should_raise_index_error_if_word_smaller_than_three_characters
    input = %w(Mary had a little lamb)
    e = assert_raises IndexError do
      string_slice(*input)
    end
    assert_equal "All arguments should be three or more characters in size", e.message
  end
end
