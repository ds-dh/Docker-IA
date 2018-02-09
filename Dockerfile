FROM jupyter/base-notebook

LABEL maintainer = "Data Science <datascience@digitalhouse.com>"


ENV NB_USER=DS-DH-2018\
	NB_UID=1001

ENV HOME=/home/$NB_USER

USER root

RUN useradd -ms /bin/bash -N -u $NB_UID $NB_USER  && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    fix-permissions $HOME && \
	fix-permissions $CONDA_DIR && \
	echo "$NB_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/notebook 


RUN mkdir /home/$NB_USER/notebooks && \
	fix-permissions /home/$NB_USER

RUN usermod -aG sudo $NB_USER

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	python-pip

RUN conda install --yes 'numpy' \
'scipy' \
'statsmodels' \
'matplotlib' \
'seaborn' \
'nltk' 

RUN pip install 'datetime' 
RUN pip install 'sqlparse' 
RUN pip install 'ipython-sql' 
RUN pip install 'sqlalchemy' 
RUN pip install 'scikit-learn' 
RUN pip install 'selenium' 
RUN pip install 'joblib' 
RUN pip install 'scikit-image'
RUN pip install 'geopandas'


USER $NB_USER
WORKDIR $HOME

CMD ["start-notebook.sh", "--NotebookApp.token=''", "--allow-root"]