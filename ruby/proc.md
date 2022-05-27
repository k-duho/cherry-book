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

### 메소드 인수로 블록을 건내는 방법

```rb
def to_en(&block)
  hellos = ["good morning", "good_afternoon", "good_afternoon"]

  hello_common(hellos, &block)
end

def to_jp(&block)
  hellos = ["おはよう", "こんにちは", "こんばんは"]

  hello_common(hellos, &block)
end


def hello_common(hellos, &block)
end

def to_jp
end

```
