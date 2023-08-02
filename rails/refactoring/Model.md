# Model

## Validation
DB에 저장이 되는 모델 인스턴스의 값 검증은 전부 Model Validation으로 정의 할 것.  
로직이 복잡한 경우에는 Custom Validation메소드를 만들어서 해도 OK

※ 레일즈 표준으로 제공하고 있는 뛰어난 Validation메소드를 이용하자(참고 [레일즈문서](https://railsguides.jp/active_record_validations.html))

## Custom Validation
아래와 같은 Validation을 모델에 추가 할 경우
```rb
validates :phone_number, phone_number: true
```

`app/validators/phone_number_validation.rb`을 부르게 된다.

## Validation구현 가이드

### 하나의 컬럼에 대해 Validation을 추가하고 싶은 경우
- Model의 validates(가장 일반적)
- ActiveModel::EachValidator의 validate_each


### 두개 이상의 컬럼 혹은 자식 모델을 포함한 전체에 복잡한 로직의 Validation을 추가하고 싶은 경우
- Model의 validates_with를 사용
- ActiveModel::Validator클래스와 validate메소드를 사용
- Custom Validation을 다른 디렉토리에 두기 싫으면 모델내에 정의 후 validate로 사용

## ActiveRecord_Relation에 대해서

### SQL이 발행되는 타이밍
Array의 메소드를 쓰는 순간 SQL이 발행된다.

### select메소드
group등에서 필요 없는 컬럼을 제외하기 위해서 쓰기도 하는데, 차라리 Serializer에서 제외하는게 더 낫다.

### default_scope
논리삭제 개념이 존재한다면 도입을 해보는 것 도 괜찮다.

### merge
merge를 잘 이용하면 scope / join / where을 조합하는게 가능.

## joins, includes, preload, eager_load의 사용에 대해(a.k.a n+1문제)
간단하게 정리하면, 내부 결합은 joins로 외부 결합은 preload를 사용한다.
문제가 있을 때 eager_load사용을 검토하면 된다.

그리고 N+1문제는 퍼포먼스에 아주 큰 영향을 주기 때문에 개발환경에서 [bullet Gem](https://github.com/flyerhzm/bullet)을 도입하여 사전에 자동검지 되도록 하자.

| 메소드       | 목적                          | 결과                                          | N+1 문제 해결       | 새로운 쿼리               | 특징                                                                              | 캐싱 처리              |
|--------------|-------------------------------|-----------------------------------------------|---------------------|---------------------------|-----------------------------------------------------------------------------------|-----------------------|
| `joins`      | INNER JOIN을 수행       | 지정된 관계에 해당하는 테이블을 조인    | X                   | 하나의 쿼리로 실행 | 연결된 테이블의 데이터를 필요로 하지 않을 때 유용. 조인된 테이블의 칼럼을 참조할 수 있다. | 캐싱 안 함          |
| `preload`    | LEFT OUTER JOIN 같은 효과| 별도의 쿼리로 관계된 객체를 로딩       | O                   | 별도의 쿼리로 실행 | 조인을 사용하지 않으므로 조인된 테이블의 칼럼을 WHERE 절에서 참조할 수 없다.                               | 캐싱 함           |
| `eager_load` | LEFT OUTER JOIN을 수행   | 모든 관계된 레코드를 함께 불러옴          | O                   | 하나의 쿼리로 실행 | 필요한 것보다 많은 데이터를 불러올 수 있으므로 신중해야 한다.                                                 | 캐싱 함           |
| `includes`   | 최적의 방법을 자동 선택  | `joins` 또는 `preload`을 사용            | O                   | 상황에 따라 다름 | Rails가 알아서 결정하므로 내부 동작에 대한 깊은 이해가 필요하다.                                             | joins 또는 preload의 캐싱처리 |


## arel_table에 대해
기본적으로 사용을 금지한다.

가독성이 나빠 유지보수성이 나쁘고, ActiveRecord로 해결이 불가능하다면 SQL을 그대로 쓰는걸 추천.
Rails에서 SQL을 쓰는건 옳지 않다고 말하는 사람들도 있는데 arel_table을 쓰면서 할 말은 아닌 것 같다.
어느게 유지보수가 쉬울지 잘 생각해보는걸 추천한다.

## enum에 대해
status와 같이 숫자로 어떤 상태를 정의하고 싶을 때 쓴다.
DB에 직접 status 문자열을 저장해서 하는 곳이 늘어나고 있지만, 아직은 숫자로 저장하는곳이 많은 듯 하다.

```rb
# _prefix: true덕분에 아래와 같은 헬퍼 메소드가 자동 생성됨.
# -> super_role? / admin_role? / common_role?
enum role: { super: 0, admin: 1, common: 2 }, _prefix: true

# _prefix: false가 디폴트. 아래와 같은 헬퍼 메소드가 자동 생성됨.
# -> super? / admin? / common?
enum role: { super: 0, admin: 1, common: 2 }


# _prefix: :test덕분에 아래와 같은 헬퍼 메소드가 자동 생성됨.
# -> test_super? / test_admin? / test_common?
enum role: { super: 0, admin: 1, common: 2 }, _prefix: :test
```
