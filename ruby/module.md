## Module

### 모듈을 쓰는 이유
- 복수의 클래스에 계승 없이 인스턴스 메소드를 추가 할 수 있다.  
  -> 관련이 없는 클래스에서 공통으로 쓰일 때 특히 유용
  -> 클래스 메소드도 가능
- 클래스명이나 상수명의 충돌을 막기위해 이름 공간을 잡아놓는다.  
  -> 이건 잘 모르겠다.
- 함수적인 역할을 메소드를 정의하고 싶을 때.
- 싱글톤 오브젝트처럼 설정치 등을 격납하고 싶을 때.

---
### Module의 정의 ・ 로드
- instance메소드의 경우 예시

```rb
module TestModule
  def print_name
    puts "name: #{self.name}"
  end
end

class Person
  attr_accessor :name

  include TestModule

  def initialize(name)
    @name = name
  end
end

person = Person.new("dev.duho")
person.print_name
=> "name: dev.duho"
```
<br>

- 클래스 메소드의 경우 예시
```rb

module TestModule
  def print_name(name)
    puts "name: #{name}"
  end
end

class Animal
  attr_accessor :name

  extend TestModule
  
  class << self
    def create_animal(name)
      print_name(name)
    end
  end
end

animal = Animal.create_animal("dev.duho")
animal.print_name
=> "name: dev.duho"
```
---
<br>

### Enumerable Module
- 루비의 반복문 처리가 가능한 클래스에 include되어 있음.
- Enumerable Module를 incldue 하면 사용 가능한 메소드들
  - map
  - select
  - find
  - count
  - 등


### Comparable Module
- 비교연산을 잘하게 해 줌
- Comparable Module를 incldue 하면 사용 가능한 메소드들
  - ==
  - !=
  - 등 루비의 기본 비교 연산자

---
<br>
### Kernel Module
- 기본적인 구문들에서 보던 애들이 정의되어 있음
- Object 클래스가 Kernel 모듈을 include중
- Kernel Module를 incldue 하면 사용 가능한 메소드들
  - puts
  - p
  - pp
  - print
  - require
  - loop
  - 등

---
<br>


### 메소드 탐색 룰
- 코드가 아래와 같을 때, 출력되는 순서
=> "[Truck] [TestB] [TestA] [Car] #<Truck:0x00007f8bb90c96c0>"

- 이 순서는 Truck.ancestors으로도 확인 가능.

```rb
module TestA
  def to_s
    "[TestA] #{super}"
  end
end

module TestB
  def to_s
    "[TestB] #{super}"
  end
end

class Car
  def to_s
    "[Car] #{super}"
  end
end

class Truck < Car
  include TestA
  include TestB

  def to_s
    "[Truck] #{super}"
  end
end

truck = Truck.new
truck.to_s
```
