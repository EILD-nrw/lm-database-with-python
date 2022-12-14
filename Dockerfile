FROM python:3.7-slim
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook matplotlib

# create user with a home directory
ARG NB_USER=jovan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}



RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

COPY README.md /home/${NB_USER}
COPY Datenbankzugriff_Util.ipynb /home/${NB_USER}
COPY Datenbankzugriff.ipynb /home/${NB_USER}

EXPOSE 8888

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
