set shell := ["bash", "-uc"]

[private]
default:
  @just --list

test: requirements
  helm unittest charts/balanced-chart

docs: requirements values-markdown json-schema

[private]
values-markdown:
  helm-docs --values-file doc-values.yaml -s file --output-file VALUES.MD

[private]
json-schema:
  helm schema

requirements:
  #!/usr/bin/env bash
  if ! helm unittest --help >/dev/null 2>&1; then
    echo "helm unittest is not installed"
    echo "Check https://github.com/helm-unittest/helm-unittest?tab=readme-ov-file#install"
    exit 1
  fi
  if ! helm schema --help > /dev/null 2>&1; then
    echo "helm-schema is not installed"
    echo "Check https://github.com/dadav/helm-schema?tab=readme-ov-file#installation"
    exit 1
  fi
  if ! helm-docs --help >/dev/null 2>&1; then
    echo "helm-docs is not installed"
    echo "Check https://github.com/norwoodj/helm-docs?tab=readme-ov-file#installation"
    exit 1
  fi