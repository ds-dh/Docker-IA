FROM jupyter/base-notebook

MAINTAINER Data Science <datascience@digitalhouse.com>

RUN usermod -l dsdh jovyan

RUN conda install --yes 'numpy' \
'scipy'\
'statsmodels'\
'sklearn'

RUN conda install --yes 'matplotlib' \
'seaborn'

