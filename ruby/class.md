## Class
※ 다른 언어와 대동소이

### Ruby에서 클래스란
- 오브젝트의 (확장 가능한)설계도.

---
### 오브젝트(인스턴스)란
- 클래스에서 만들어진 데이터의 뭉텅이
---
### 루비 메소드의 가시성
- private메소드는 서브 클래스에서도 사용이 가능하니 주의.
- 서브 클래스에서 슈퍼 클래스의 private메소드를 오버라이드 해버리는 경우가 있으니 주의.
  - 가시성도 오버라이드 가능.

```rb
class Car
  private

  def name
    'car name method'
  end
end

class Truck < Car

  def puts_name
    "name: #{name}"
  end
end

truck = Truck.new
truck.puts_name
=> "name: car name method"
```

#### 클래스 메소드의 가시성에 대해

- 클래스 메소드를 private가시성으로 설정하기 위해서는 두가지 방법이 존재.
- class << self를 많이 쓰니 참고.

```rb
class User
  def self.create_user
  end

  private_class_method :hello
end

class User
  class << self
    def create_user
    end
  end
end

```


---

### class와 when .. case절의 조합
- case의 오브젝트가 어떤 클래스에 속하는지 when절에서 판단하는게 가능.

```rb
def test(object)
  case object
  when Array
    puts "object is array"
  when String
    puts "object is string"
  when Hash
    puts "object is hash"
  else
    puts "nothing"
  end
end

object = "string"
test(object)
=> "object is string"

```
