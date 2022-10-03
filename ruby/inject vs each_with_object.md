## each_with_object
 - 개체 컬렉션을 해쉬로 변환 할 때 아주 유용하다.
 - 마지막 줄에 반환값을 적을 필요가 없다.

```rb
#
# User has name and age
# When I want hash like { user.name => user.age }
#

# use each_with_object
User.all.each_with_object({}) do |user, hash|
  hash[user.name] = user.age
end

# use inject
User.all.inject({}) do |hash, user|
  hash[user.name] = user.age
  hash # << 이 녀석
end


#
# When I want each char and return value of char.ord with hash
# like { a => a.ord }
#

# use each_with_object
("a".."z").each_with_object({}) do |char, hash|
  hash[char] = char.ord
end

# use inject
("a".."z").inject({}) do |hash, char|
  hash[char] = char.ord
  hash # << 여기도
end

```


## inject
 - 불변객체(immutable object)에 쓰는게 좋아보임(ex: int, date, etc..)
 - merge와 상성이 좋다. (merge는 두개의 해쉬를 합쳐서 return하므로 따로 반환값을 적어주지 않아도 괜찮음)

```rb
(1..10).inject(:+)
=> 55

(1..10).inject(100 ,:+)
=> 155

num = 100
(1..10).inject(num ,:+)
=> 155
```

## 참고 사이트
- https://medium.com/@Fdel15/ruby-each-with-object-or-inject-a737bb90cdd8
- https://blog.arkency.com/inject-vs-each-with-object/
