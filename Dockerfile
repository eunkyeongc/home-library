FROM python:3.12-slim
# slim을 안적으면 파일이 엄청 커짐.

WORKDIR /app 
# 컨테이너 내부에 존재하는 가상의 작업폴더

# --- 패키지 설치 ---
COPY requirements.txt .
# 로컬의 파일을 컨테이너 안으로 복사. "."은 루트를 의미함.


RUN pip install --no-cache-dir -r requirements.txt
# RUN은 이미지를 만드는 빌드 시점에 한 번 실행되는 명령어
# --no-cache-dir은 pip가 install 후 다운로드 캐시를 이미지 안에 남지기 않게 한다. 

# --- 소스 코드 복사 ---
COPY main.py .
COPY database.py .
COPY models.py .
COPY streamlit_app.py .

COPY services/ ./services/
COPY templates/ ./templates/
COPY static/ ./static/

# --- 포트 문서화 ---
# 컨테이너가 몇번 포트를 사용할 예정인지 문서로 남기는 명령어
EXPOSE 8000
EXPOSE 8501

# --- 기본 실행 명령 ---
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
