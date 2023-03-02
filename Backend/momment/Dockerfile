# ./Dockerfile
FROM		 python:3.9.12
WORKDIR		 /home/ubuntu/Media_Project/Backend/momment

# install Package
COPY requirements.txt ./
RUN pip install -r requirements.txt

# copy all src files
COPY . .

# run the application on the port 8000
EXPOSE 8000

# gunicorn 배포 명령어
# CMD["gunicorn", "--bind", "허용하는 IP:열어줄포트", "project.wsfi:application"]
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "momment.wsfi:application"]
