FROM freakhill/guixbuilder:latest AS guixbuilder
RUN pack /usr/local/bin s6 bash

### build our final image
FROM ubuntu:latest

COPY --from=guixbuilder /packed.tar.gz /
RUN tar xf /packed.tar.gz && rm /packed.tar.gz

CMD = ["/bin/bash"]
