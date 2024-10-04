FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 25565 8081 443 8443 22

COPY . .

RUN echo '#!/bin/bash\n\
java -Xms64M -Xmx300M -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15 -Dterminal.jline=false -Dterminal.ansi=true -jar waterfall-1.19-535.jar << EOF &\n\
confirm-code 6065fa3d98\n\
EOF\n\
wait' > /start.sh && chmod +x /start.sh

CMD ["/start.sh"]
