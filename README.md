# A Causal Inference Perspective on Therapist Effects

This repository contains the code required to reproduce all figures and simulations reported in the manuscript, *A Causal Inference Perspective on Therapist Effects* (Magnusson, *in preparation*). 

## Materials
- [Preprint](https://psyarxiv.com/f7mvz)
    - A publicly available version of the manuscript in advance of peer-review and formal publication
- [OSF repository](https://osf.io/kyxet/)
- Online analysis supplement ([PDF](https://github.com/rpsychologist/causal-therapist-effects-paper/blob/main/docs/magnusson-2023-causal-therapist-effects.pdf), [HTML](https://rpsychologist.github.io/causal-therapist-effects-paper))
    - The rendered versions of `supplement.qmd`
- [Interactive visualization](https://rpsychologist.com/therapist-effects)
    - An interactive visualization of the overlap measures described in the manuscript
    
## Reproducibility
You can render the supplement using either your local R installation or by using Docker.

The Quarto files will be output to `docs/` and figures to `figures/`.

### Build using a local R installation
The following dependencies are needed:
- R (v4.3.0)
- Quarto (v1.3.353)
    - With a working LaTeX installation
- Renv (v0.17.3)

Then simply run:
```bash
R -e 'renv::restore()'
quarto render
```

### Build using Docker
You can also build the project using Docker, without having to install any additional dependencies.

```bash
docker build \
    --build-arg R_VERSION=4.3.0 \
    --build-arg QUARTO_VERSION=1.3.353 \
    --build-arg RENV_VERSION=0.17.3 \
    -t causal-therapist-effects .
```

Then use the Docker image to run the simulation and render the Quarto project inside a new container.

```bash
docker run \
    --rm \
    -v "$(pwd)/supplement.qmd:/home/supplement.qmd" \
    -v "$(pwd)/_quarto.yml:/home/_quarto.yml" \
    -v "$(pwd)/docker/figures:/home/figures" \
    -v "$(pwd)/docker/docs:/home/output" \
    -v "$(pwd)/docker/tmp:/home/tmp" \
    -e MAX_CORES=8 \
    -e N_SIM=10000 \
    causal-therapist-effects
```
The variable `MAX_CORES` controls how many CPU cores the simulation will use, and `N_SIM` sets the number of simulations.

Remove `./docker/tmp/simulation.rds` to rerun the simulation.
