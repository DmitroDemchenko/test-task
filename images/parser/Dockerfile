FROM python:3
RUN pip install  Flask

ADD parser.py /

EXPOSE 9001

CMD [ "python", "./parser.py" ]
