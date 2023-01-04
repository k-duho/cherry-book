## Hash를 쓸 때 주의점

### ***hash default값을 쓰는 걸 검토하자.***
 - 정수, 문자열 같이 확실하게 들어가는게 정해져있을 때 써먹을 수 있을 듯.
 - 잘만 쓰면 ||= 같은 불필요 처리를 줄일 수 있다.
```rb
# - before
def example(array)
  array.reduce({}) do |hash, key|
    hash[key] ||= 0
    hash[key] += 1
    hash
  end
end


# - after
def example(array)
  array.reduce(Hash.new(0)) do |hash, key|
    hash[key] += 1
    hash
  end
end
```

### ***해쉬에서 디폴트 값을 잘못 쓰면 지옥이다.***
 - hash를 선언 했을 때 디폴트 값으로 빈 배열을 지정했지만, 디폴트값이 변화해버린다.  
   -> 선언 시에 건내준 배열을 전부 참조해서 일어난다.
```rb
hash = Hash.new([])

hash[:foods] << "rice"
hash[:drinks] << "coke"
hash.default
# => ["rice", "coke"]
hash.keys
# => []
hash[:a]
# => ["rice", "coke"]
```

 - 디폴트값으로 안전한 빈 배열을 원하는 경우 블록으로 지정할 것.
```rb
hash = Hash.new {[]}

hash[:foods] << "rice"
hash
# => {}

hash.default
# => nil

hash[:foods] = hash[:foods] << "rice"
# => { :foods => ["rice"]}

hash.default
# => nil

hash[:a]
# => ["rice", "coke"]
```

 
- 해쉬가 키를 포함하고 있는가 확인 할 때는 nil이 돌아올 것을 전제로 구현하지말것.  
  -> has_key?가 베스트라고 하는데, 값이 있으면 true 없으면 false로 하는게 왜 나쁜지 모르겠다. 실제로 이 방법을 많은 엔지니어들이 쓰고 있음.  
  -> 루비는 nil, false이외가 전부 true니까 이런 주장을 하는 것 같음.  
  -> 해쉬의 값이 공백 문자열을 포함할 경우에는 쓸만 할 수도..

```rb
# NG
hash = Hash.new
if hash[:missing_key]
else
end

# best practice (이게?)
if hash.has_key? :missing_key
else
end
```


- 무효한 키를 줄 가능성이 있을 경우에는 해쉬의 디폴트값을 사용해선 안된다.
- 디폴트값을 사용하기보다 Hash#fetch를 사용하는게 더 안전할 경우가 있다. 
