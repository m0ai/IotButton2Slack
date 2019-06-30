# 놀고 있는 AWS IOT Button을 활용하기
집에서 방치되어있는 AWS IoT 버튼을 10분을 투차해서 어떻게든 활용해보아요.
설정하기를 완료하면 aws lambda를 이용하여 간단하게 슬랙 메세지를 보낼 수 있어요.

# 필요사항
``
terraform 0.11 
python3.6
집에서 놀고 있는 AWS IoT 버튼 1개
버튼을 핸들링할 aws 계정 
```

[terraform이 무엇인가요](https://www.hashicorp.com/blog/announcing-terraform-0-12) >= 0.12

# 설정하기

## 인프라구성하기
```bash
make configure # lambda에서 사용할 requests 패키지를 설치합니다.
make publish   # lambda에 업로드할 zip을 생성합니다.
```
> 두 명령어를 실행하여 aws 계정에 업로드할 lambda 함수를 준비합니다.



```tf
# terraform/locals.tf 
locals {
  slack_incoming_url = ""           # 메세지를 전송할 슬랙 채널의 incoming url
  single_click_msg = "Single Click" # 한번 눌렀을 때 슬랙으로 전송되는 메세지
  double_click_msg = "Double Click" # 두번 눌렀을 때 슬랙으로 전송되는 메세지
  long_click_msg = "Long Click"     # 길게 눌렀을 때 슬랙으로 전송되는 메세지
}
```
> terraform/locals.tf 파일을 수정하여 정보를 업데이트합니다. 


```bash
export AWS_ACCESS_KEY_ID=" u_r_accesskey"
export AWS_SECRET_ACCESS_KEY="u_r_asecretkey"
export AWS_DEFAULT_REGION="ap-northeast-2"
```
> 테라픔으로 람다를 생성하기 위해 설정합니다.


```bash
cd terraform
terraform plan
terraform apply 
```
> 설정이 완료되었으면 본인의 aws 계정에 인프라를 생성합니다.

## IoT 버튼과 인프라 연결하기

[aws lambda 홈페이지](https://ap-northeast-2.console.aws.amazon.com/lambda/home?)에 접속하여 `IotButton2SlackNotifter` 람다 함수를 클릭하여 `Configuration` 매뉴에 접속합니다.


좌측 `Designer/트리거 추가/AWS IoT` 매뉴를 눌러 `트리거 구성` 섹션에서 필요한 항목(Device Serial Number)을 채워 `인증서 및 키 생성` 버튼을 누릅니다 .

버튼을 누른 후 AWS에서 IoT 버튼에서 사용할 키를 구성하라고 안내를 해줍니다. 이를 완료한 후 추가를 누릅니다. 

완료되었습니다. 이제 버튼을 눌러 버튼을 써보아요.

## 결과

![image](https://user-images.githubusercontent.com/13462317/60394901-36362b80-9b66-11e9-869a-e6b3b60b5562.png)
