FROM rocker/shiny-verse:latest

RUN sudo apt-get update; exit 0

# install packages
RUN R -e "install.packages(c('shinydashboard','DT'), repos='https://cran.rstudio.com/')"

# copy files
#COPY shinyapp /srv/shiny-server/
COPY *.R /srv/shiny-server/
RUN mkdir -p /srv/shiny-server/data
COPY data /srv/shiny-server/data

# set port to 80
EXPOSE 80
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf
CMD ["/usr/bin/shiny-server"]
