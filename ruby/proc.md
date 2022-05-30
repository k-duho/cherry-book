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
