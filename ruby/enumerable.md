## max_by에 대해서
 - sort와 sort_by랑 같음.
 - min_by도 존재.

```rb
### Hash
{ 3 => 2, 1 => 4, 2 => 5 }.max_by { |key, value| value }
=> [2, 5]

{ 3 => 2, 1 => 4, 2 => 5 }.max_by { |key, value| key }
=> [3, 2]

### Array
[1, 2, 3, 4 ,5].max_by { |num| num / 2 }
=> 2

[1, 2, 3, 4 ,5].max_by { |num| num / 5 }
=> 5

[1, 2, 3, 4 ,5].max_by { |num| num / 10 }
=> 1
```
