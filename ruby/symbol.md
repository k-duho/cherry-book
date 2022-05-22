## Symbol

### Symbol의 특징

- 심볼은 루비 내부에서 상수로 관리  
  그래서 같은 심볼을 여러번 선언한 후, 오브젝트ID(object_id)를 확인해보면, 같은 오브젝트ID.

- 오브젝트ID가 같으므로, 심볼의 비교 연산은 속도가 빠르다.
- 메모리 사용량을 줄일 수 있다.


---
<br>

### 선언 방법

- 선두에 콜론을 두고 선언이 가능하다

```rb
:en
:EN
:empty?
:_empty?
:@names
:$names
:==
:+
:"name" => (== :name)
:"my name is"
```

- 아래의 예시는 Syntax에러 발생
```rb
:000
:my-name-is
:my name is
:()
```

---
<br>

### 용도

- 코드의 가독성을 높이고 싶을 때
  - 메소드 키워드인수(인수가 무엇을 하는지 명확히 하고 싶을 때)  
    -> 메소드명으로 인수가 뭐에 쓰일지 예상이 안갈때 유용해보인다.
  - case when문
- hash를 사용할 때(key값)
- 문자열로 비교하고 있으면, 심볼로 리팩토링 가능한 지 생각해 볼것
  - case when문

<br>

### ruby 3.0부터 주의

- 메소드 선언시 `**nil`을 지정하면, 키워드 인수를 받지 않겠다는 뜻
- hash오브젝트를 건내주는건 가능.

#### 3.0이전
```rb
def example_method(*args)
  p args
end

=> example_method(name: "이름")
=> [{:name => "이름"}]
```

#### 3.0이후

```rb
def example_method(*args)
  p args
end

=> example_method(name: "이름")
=> Error

=> example_method({name: "이름"})
=> [{:name => "이름"}]
```



