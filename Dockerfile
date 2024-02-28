FROM python:3.8-slim-buster
WORKDIR /app
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY app.py ./
COPY templates ./templates/
COPY test_app.py ./
EXPOSE 5000
CMD ["python","app.py"]
