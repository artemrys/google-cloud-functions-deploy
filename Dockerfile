FROM google/cloud-sdk:417.0.1

COPY pipe /usr/bin/

ENTRYPOINT ["/usr/bin/pipe.sh"]
