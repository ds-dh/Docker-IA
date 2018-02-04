FROM jupyter/base-notebook

LABEL maintainer = "Data Science <datascience@digitalhouse.com>"

CMD ["/bin/bash", "useradd", "--disabled-password", "--create-home", "DS-DH-2018"]

CMD ["/bin/bash", "echo", "DS-DH-2018:x:1001:100:DS-DH-2018:/home/DS-DH-2018:/bin/bash", ">>" "/etc/passwd"]

CMD ["bin/bash", "cat", "/etc/passwd"]

#RUN --user root useradd -ms /bin/bash DS-DH-2018
#RUN conda install --yes 'numpy' 
# 'scipy'\
# 'statsmodels'\
# 'sklearn'

#RUN conda install --yes 'matplotlib' 'seaborn'

USER DS-DH-2018
WORKDIR /home/DS-DH-2018