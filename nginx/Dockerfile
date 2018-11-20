FROM debian:stretch-slim

MAINTAINER Dirk Winkel <it@polarwinkel.de>

ENV DEBIAN_FRONTEND noninteractive

ENV VERSION "1"

USER root

RUN apt-get update && apt-get install -y --no-install-recommends nginx nano

COPY default /etc/nginx/sites-enabled/default

#COPY entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh

#ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"] 
 
