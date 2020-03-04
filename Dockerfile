FROM python:3.7-slim

COPY requirements.txt /
RUN pip install -r /requirements.txt

COPY pipe /
COPY LICENSE.txt pipe.yml README.md /

ENTRYPOINT ["python3", "/pipe.py"]


