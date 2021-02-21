# Dockerfile for AUTO / anaconda3
# includes LaTeX distribution to use LaTeX in plots and to build AUTO manual

# based on anaconda3
FROM continuumio/anaconda3

# install gfortran, xvfb, AUTO
RUN apt-get update && \
    apt-get -y install make gfortran xvfb && \
    git clone https://github.com/auto-07p/auto-07p.git auto && \
    cd /auto && \
    ./configure && \
    make 

# install pyvirtualdisplay
RUN pip install pyvirtualdisplay

# install TeXlive
RUN apt-get install texlive-latex-base texlive-latex-extra texlive-fonts-recommended cm-super xzdec dvipng ghostscript fig2dev -y

# build AUTO manual
RUN cd /auto/doc && \
    make

# add AUTO to path
ENV PATH="/auto/cmds:/auto/bin:${PATH}"
ENV PYTHONPATH="/auto/python:/auto/python/auto"
ENV AUTO_DIR="/auto"
ENV HOME="/auto"

WORKDIR /auto

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]

# CMD [ "/bin/bash" ]