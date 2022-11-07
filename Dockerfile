FROM google/cloud-sdk:408.0.1

COPY pipe /usr/bin/

ENTRYPOINT ["/usr/bin/pipe.sh"]
