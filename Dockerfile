FROM google/cloud-sdk:416.0.0

COPY pipe /usr/bin/

ENTRYPOINT ["/usr/bin/pipe.sh"]
