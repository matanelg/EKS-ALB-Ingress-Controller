FROM tensorflow/tensorflow
RUN apt-get update -y
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
RUN gdown --id 19yICdtSbU_YkQBRxJ2if9KJwUL1oY5xs
EXPOSE 5000
CMD gunicorn --bind=0.0.0.0:5000 tensorflow_app:app
