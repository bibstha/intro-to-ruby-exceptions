module IntroToRuby
  EXAMPLE_SECRETS = ["het", "keca", "si", nil, "iel"]

  # Tasks
  #
  # 1. You are not allowed to modify method `decode`
  # 2. Create a method called `decode_all` that accepts an array as input.
  # 3. `decode_all` should call decode (the world's worst encryption algorithm) with each string, rescuing on Exception.
  # 4. decode will record each secret uncovered so far using announce.
  def decode(jumble)
    secret = jumble.split("").rotate(3).join("")
    announce(secret)
    secret
  end

  def decode_all(secrets)
    secrets.map do |secret|
      begin
        decode(secret)
      rescue NoMethodError
      end
    end
  end
end


# do not modify the code below
# it includes test case for the code above

require 'minitest/autorun'
require 'minitest/pride'

class TestDecoder < Minitest::Test
  class Mock
    include IntroToRuby
    attr_accessor :secrets

    def initialize
      @secrets = []
    end

    def announce(secret)
      secrets << secret
    end
  end

  def test_decode_all_does_not_raise_exception
    mock = Mock.new
    mock.decode_all(IntroToRuby::EXAMPLE_SECRETS)
    expected_secrets = ["het", "akec", "is", "iel"]
    assert_equal expected_secrets, mock.secrets
  end
end
