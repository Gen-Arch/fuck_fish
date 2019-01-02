FROM docker.elastic.co/elasticsearch/elasticsearch:6.3.2

RUN elasticsearch-plugin install analysis-kuromoji

COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
