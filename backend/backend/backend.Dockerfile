FROM python:3.11.4-slim-bullseye
LABEL maintainer="jerlendds <jerlendds@openinfolabs.com>"

WORKDIR /app/
ENV PYTHONPATH=/app/

RUN apt-get -y update && apt-get -y install apt-transport-https nmap git wget gnupg curl chromium chromium-driver && \
    apt-get clean;
COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir --upgrade pip && \
  pip3 install --no-cache-dir -r /app/requirements.txt

# @todo change to PyPi package for release 0.0.5 and remove gitmodules
COPY osintbuddy-plugins /osintbuddy-plugins/
RUN pip3 install /osintbuddy-plugins/
COPY gremlinpy /gremlinpy/
RUN pip3 install /gremlinpy/

COPY app/ /app/

CMD ["/bin/bash", "-c", "./start.sh"]
