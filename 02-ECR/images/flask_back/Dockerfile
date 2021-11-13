FROM python:3.9-slim
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD gunicorn --bind=0.0.0.0:5000 app_file:app
