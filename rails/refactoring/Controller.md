# Controller

기본적으로 컨트롤러에는 비즈니스 로직을 넣지 않는 것을 추천한다.  
컨트롤러에서는 통신에 필요한 최소한의 로직만 넣을 것이 베스트다.

## 컨트롤러에 써도 문제가 없는 메소드

### HTTP통신 관련 메소드  

- respond_to, 
- flash
- redirect_to
- render
- 스트롱 파라미터 관련 params.permit

### 단순한 데이터 CRUD관련 메소드
- new
- find
- save
- destroy

### 다른 레이어의 클래스에 존재하는 메소드
- Model
- Service
- Operation
- etc


## concerns폴더에 대해서
컨트롤러에서 사용되는 공통된 로직을 이곳에 정의 후, 각 컨트롤러에서 include해서 쓴다.

## API용 컨트롤러와 화면표시용 컨트롤러
둘 다 하나의 컨트롤러에서 분기를 통해 대응이 가능하지만, 유지보수 측면에서 보았을 때, 따로 나누어 놓는게 정신건강에 이롭다.
