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
'nltk' \

RUN pip install 'datetime' 'sqlparse' 'ipython-sql' 'sqlalchemy' 'scikit-learn' 'selenium' 'joblib' 'scikit-image' 'unidetcode' 'geopandas'


USER $NB_USER
WORKDIR $HOME

CMD ["start-notebook.sh", "--NotebookApp.token=''", "--allow-root"]