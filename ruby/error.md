## 유스 케이스: 커스텀한 에러 클래스의 에러를 발생시킨 후, 인수를 받아 메세지를 정의하고 싶을 때

# ```rb
class CustomError < StandardError
  def initialize(msg1, msg2)
    @time = Time.now
    @msg1 = msg1
    @msg2 = msg2
    # NOTE: 인수로 지정하는게 에러의 message. error.message의 반환값
    super(message)
  end

  def message
    "[#{@time}]error message\nmsg1: #{@msg1}\nmsg2: #{@msg2}"
  end
end

class ErrorTest
  class TestError < CustomError; end

  def raise_for_test
    begin
      raise TestError.new("msg1", "msg2")
    rescue CustomError => exception
      p exception.message
    end
  end
end

error_test = ErrorTest.new
error_test.raise_for_test
=> "[2022-09-28 20:05:16 +0900]error message\nmsg1: msg1\nmsg2: msg2"
# ```


