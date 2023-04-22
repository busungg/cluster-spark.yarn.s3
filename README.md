# cluster-spark.yarn.s3

docker compose로 s3 와 연동되는 spark + yarn cluster 구축 프로그램입니다.

### 1. 사용 방법

1. docker를 실행할 곳으로 해당 git을 clone 받습니다.
2. dockerfile의 master, worker 폴더의 spark.conf에 있는 spark 설정들을 원하는대로 설정합니다.
3. dockerfile의 master, worker 폴더의 hadoop.etc.hadoop에 있는 hadoop 설정들을 원하는대로 설정합니다.
4. python3 cluster.py up cluster명 master=1 worker={숫자}
   1. cluster명으로 master 1개 worker node 숫자 만큼의 container 생성이 되고 spark가 동작하게 됩니다.
   2. 생성된 클러스터는 192.168.0.0/24 네트워크에 존재하며 각 container의 옵션은 dist 폴더에 생성되는 compose 파일을 참고합니다.
