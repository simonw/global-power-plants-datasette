FROM python:3.6-slim-stretch
RUN apt-get update
RUN apt-get install -y python3-dev gcc git
ADD datasette/dist/*.whl .
RUN pip install *.whl
RUN pip install https://github.com/simonw/datasette-cluster-map/archive/size-max.zip
ADD global-power-plants.db .
ADD metadata.json .
RUN datasette inspect global-power-plants.db --inspect-file inspect-data.json

EXPOSE 8001

CMD datasette serve global-power-plants.db --host 0.0.0.0 \
    --cors --port 8001 --inspect-file inspect-data.json -m metadata.json
