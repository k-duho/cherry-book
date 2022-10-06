## 1장

### true, false, nil

- nil은 이용가능한 정보가 없거나, 요청받은 정보가 없을때만 사용을 추천

```rb
[].first
=> nil

{ a: 1 }[:b]
=> nil
```

- 루비에서 메소드가 성공시 true를 리턴하면, 실패시에는 false를 리턴해야 한다.

- 리턴값이 true, false가 아닌 메소드는 실패했을 때, nil을 리턴하거나 예외 처리를 발생시켜야 한다.

```rb
"abc".gsub!("z", "")
=> nil

[1,3,5].select!(&:odd?)
```

