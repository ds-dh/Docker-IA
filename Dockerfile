FROM jupyter/base-notebook

LABEL maintainer = "Data Science <datascience@digitalhouse.com>"


ENV NB_USER=DS-DH-2018\
	NB_UID=1001

ENV HOME=/home/$NB_USER

USER root

RUN useradd -ms /bin/bash -N -u $NB_UID $NB_USER  && \
    mkdir -p $CONDA_DIR && \
    chown -R $NB_USER:$NB_GID $CONDA_DIR && \
    fix-permissions $HOME && \
	fix-permissions $CONDA_DIR && \
	echo "$NB_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/notebook 


RUN mkdir /home/$NB_USER/notebooks && \
	fix-permissions /home/$NB_USER

RUN usermod -aG sudo $NB_USER

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	python-pip \
	git 

RUN apt-get -y install gcc

RUN conda install --yes 'numpy'
RUN conda install --yes 'scipy'
RUN conda install --yes 'statsmodels'
RUN conda install --yes 'matplotlib'
RUN conda install --yes 'seaborn' 
RUN conda install --yes 'nltk'

RUN conda install --yes 'setuptools' 
RUN conda install --yes 'sqlite' 
RUN conda install --yes 'bokeh' 
RUN conda install --yes 'pandas' 
RUN conda install --yes 'plotly' 
RUN conda install --yes 'scrapy' 
RUN conda install --yes 'dill'


RUN pip install --upgrade 'ez_setup'
RUN pip install 'multiprocess' 
RUN pip install 'datetime' 
RUN pip install 'sqlparse' 
RUN pip install 'ipython-sql' 
RUN pip install 'sqlalchemy' 
RUN pip install 'scikit-learn' 
RUN pip install 'selenium' 
RUN pip install 'joblib' 
RUN pip install 'scikit-image'
RUN pip install 'unidecode'
RUN pip install 'geopandas'

RUN pip install --upgrade --quiet 'git+https://github.com/esafak/mca'

USER $NB_USER
WORKDIR $HOME

CMD ["start-notebook.sh", "--NotebookApp.token=''", "--allow-root"]