FROM google/cloud-sdk:273.0.0

COPY pipe /usr/bin/

ENTRYPOINT ["/usr/bin/pipe.sh"]
