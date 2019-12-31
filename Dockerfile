FROM openjdk:8

RUN curl -o CTP-installer.jar http://mirc.rsna.org/download/CTP-installer.jar
RUN jar xf CTP-installer.jar CTP

RUN apt update && apt install -y unzip
RUN curl -o linux-x86_64.zip http://mirc.rsna.org/ImageIO/linux-x86_64.zip
RUN unzip linux-x86_64.zip
RUN cp linux-x86_64/clibwrapper_jiio-1.2-pre-dr-b04.jar $JAVA_HOME/jre/lib/ext
RUN cp linux-x86_64/jai_imageio-1.2-pre-dr-b04.jar $JAVA_HOME/jre/lib/ext
RUN cp linux-x86_64/libclib_jiio.so $JAVA_HOME/jre/lib/i386
RUN cp linux-x86_64/libclib_jiio.so $JAVA_HOME/jre/lib/amd64
RUN mkdir $JAVA_HOME/jre/i386
RUN cp linux-x86_64/libclib_jiio.so $JAVA_HOME/jre/i386

RUN echo "cd /CTP && java -jar Runner.jar" > /run.sh
RUN curl -o /CTP/config.xml https://raw.githubusercontent.com/CTMM-TraIT/trait_ctp/master/site_configurations/CTMM_TRAIT_TEST/config.xml

EXPOSE 80
EXPOSE 104

CMD ["sh", "/run.sh"]
