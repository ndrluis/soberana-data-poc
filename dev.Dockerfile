FROM python:3.9

RUN pip install pandas
RUN pip install pyarrow
RUN pip install requests
RUN pip install psycopg2
RUN pip install sqlalchemy
