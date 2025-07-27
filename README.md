# balanced-chart
A simple generic helm chart that can be used with multiple projects.

In sailing the sails can be balanced so that there is no steering load on the tiller. The goal is to get the boat to track straight with minimal helm input.

This chart aims to act as a basic generic helm chart that will deploy a service with a minimal set of inputs using common best practices.

# Getting Started

Using balanced chart requires a helm [Chart.yaml](https://helm.sh/docs/topics/charts/#the-chartyaml-file) file and a values file if you wish to change any of the defauts.  Check the [values documentation](charts/balanced-chart/VALUES.MD) for possible settings and overrides.  Building a chart is done by combining your Chart.yaml file and values files with the chart templates.

The minimium required values are:
- the image to run
- the image tag
- resources resource limits/requests for the container.

```yaml
image:
  repository: ghcr.io/balanced-chart
  tag: 1.0.1

resources:
  limits:
    cpu: 0.5
    memory: 512Mi
  requests:
    cpu: 0.25
    memory: 256Mi
```

# Developing

Install the [just](https://github.com/casey/just) command runner to use project commands which are located in the [justfile](./justfile).  After intalling just run `just` to get started.

Unit testing is done with [helm unittest](https://github.com/helm-unittest/helm-unittest).

Documentation generate with [helm-docs](https://github.com/norwoodj/helm-docs).

Schema with [helm-schema](https://github.com/dadav/helm-schema).
