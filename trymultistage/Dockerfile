FROM freakhill/guixbuilder:latest AS guixbuilder
RUN pack s6 bash

### build our final image
FROM ubuntu:latest

COPY --from=guixbuilder /target.tar.gz /
RUN tar xf /target.tar.gz && rm /target.tar.gz

CMD = ["/bin/bash"]
