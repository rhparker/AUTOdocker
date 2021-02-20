# Dockerfile for AUTO / anaconda3

# based on anaconda3
FROM continuumio/anaconda3

# install gfortran and AUTO
RUN apt-get update && \
    apt-get -y install make gfortran xvfb && \
    git clone https://github.com/auto-07p/auto-07p.git auto && \
    cd /auto && \
    ./configure && \
    make 

RUN pip install pyvirtualdisplay

# add AUTO to path
ENV PATH="/auto/cmds:/auto/bin:${PATH}"
ENV PYTHONPATH="/auto/python"
ENV AUTO_DIR="/auto"
ENV HOME="/auto"

WORKDIR /auto

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]

# CMD [ "/bin/bash" ]