## Proc

### 블럭과 yield
- yield => 건내준 블록을 실행한다.
- yield를 적은 만큼 실행한다.
- yield가 블록을 실행하려는데 블록이 없으면 에러가 발생한다.

```rb
def product_name
  puts "product_name_A"
  yield
  puts "product_name_C"
end

product_name do
  puts "product_name_B"
end

=> "product_name_A"
"product_name_B"
"product_name_C"
```
---

<br>

### yield를 쓰는 방법①
- yield에도 인수를 쓸 수 있다.

```rb
def product_name
  puts "product_name_A"
  yield "head"
  puts "product_name_C"
end

product_name do |prefix|
  puts "#{prefix}_product_name_B"
end

=> "product_name_A"
"head_product_name_B"
"product_name_C"
```
<br>

- 인수가 있고 없고에 따른 에러는 없다.
```rb
def product_name
  puts "product_name_A"
  yield
  puts "product_name_C"
end

product_name do |prefix|
  puts "#{prefix}_product_name_B"
end

=> "product_name_A"
"_product_name_B"
"product_name_C"
```
<br>

- 인수를 복수 지정할 경우, 전부 다 받을 수도 있고. 전혀 지정하지 않아도 된다.
```rb
def product_name
  puts "product_name_A"
  yield
  puts "product_name_C"
end

product_name do |prefix|
  puts "#{prefix}_product_name_B"
end

=> "product_name_A"
"_product_name_B"
"product_name_C"
```

<br>

---

### 메소드 인수에 블록을 명시적으로 지정하는 방법
- yield대신에 `&`가 붙은 명명
```rb
def hello_common(&block)
  puts "좋은 아침"
  text = block&.call("안녕")
  puts text
  puts "좋은 밤"
end

hello_common do |t|
  t * 2
end
=> 좋은 아침
안녕안녕
좋은 밤

hello_common # => 인수를 지정하지 않아도 Argument Error는 발생하지 않음 
=> 좋은 아침

좋은 밤
```

<br>

---

### 블록 인수의 개수를 확인하는 법
 - block.arity # =>return Integer
```rb
def hello(&block)
  puts "좋은 아침"
  text = if block.arity == 1
           yield "안녕"
         elsif block.arity == 2
           yield "안", "녕"
         end
  puts text
  puts "좋은 밤"
end

hello do |h|
  h * 2
end

=> 좋은 아침
안녕안녕
좋은 밤



hello do |h1, h2|
  h1 * 2 + h2 * 2
end

=>좋은 아침
안안녕녕
좋은 밤
```

<br>

---

### Proc
 - 어원: `proc`edure

 - 선언 및 실행

```rb
do_something_proc = Proc.new { "do something!" }
do_something_proc.call
=> "do something!"


do_something_proc = Proc.new { |num| puts "puts #{num}!!" }
do_something_proc.call(1)
=> "puts 1!!"


do_something_proc = Proc.new { |num1, num2| puts "puts #{num1} and #{num2}!!" }
do_something_proc.call(1, 3)
=> "puts 1 and 3!!"
```

 - Proc은 오브젝트이다.  
   -> 변수에 넣어서 다른 메소드에 건내준다던가, Proc오브젝트의 메소드를 부를 수 있다.
   
```rb
def hello_common(&block)
  puts "좋은 아침"
  text = block&.call("안녕")
  puts text
  puts "좋은 밤"
end

# 둘 다 같은 결과
hello_common do |t|
  t * 2
end

test_proc = Proc.new { |text| text * 2 }
hello_common(test_proc)
```
  
 - &없이 Proc을 인수로 지정하고 싶을 때

```rb
def hello_common(proc)
  puts "좋은 아침"
  text = proc.call("안녕")
  puts text
  puts "좋은 밤"
end

hello_proc = Proc.new { |h| h * 3 }
hello_common(hello_proc)

=> 좋은 아침
안녕안녕안녕
좋은 밤
```

 - 블록은 하나의 메소드당 하나만 인수로 지정 가능하지만, proc은 제한이 없다.


<br>

---

### Proc과 lambda의 차이

#### 선언 방법
```rb
## Proc
Proc.new { |a| puts a }
proc { |a| puts a }

## lambda
-> (a) { puts a }
lambda { |a| puts a }
```

#### 인수의 차이
```rb
## Proc은 인수의 개수가 안맞아도 에러가 일어나지 않는다
test_proc = Proc.new { |a, b| a.to_i + b.to_i }
test_proc.call(1)

## lambda는 인수 개수를 체크
test_lambda = lambda { |a, b| a.to_i + b.to_i }
test_lambda.call(1)
=> ArgumentError (wrong number of arguments (given 1, expected 2))

```


