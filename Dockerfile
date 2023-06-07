ARG R_VERSION
FROM rocker/r-ver:${R_VERSION}

## Install dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    pandoc \
    curl \
    cmake \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libxt6 \
    libcairo2-dev \
    libv8-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev

## RENV
WORKDIR /home
ARG RENV_VERSION
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
COPY renv.lock renv.lock
RUN mkdir -p renv
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
COPY powerlmm_0.4.0.9000.tar.gz .
RUN R -e 'renv::restore()'

## Quarto
ARG QUARTO_VERSION
RUN curl -o quarto.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
RUN apt install ./quarto.deb
RUN rm quarto.deb
RUN quarto install tool tinytex

## Quarto script
COPY docker-quarto.sh .
RUN chmod +x docker-quarto.sh

CMD ["./docker-quarto.sh"]