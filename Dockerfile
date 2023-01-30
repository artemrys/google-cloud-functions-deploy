FROM google/cloud-sdk:415.0.0

COPY pipe /usr/bin/

ENTRYPOINT ["/usr/bin/pipe.sh"]
