set shell := ["bash", "-uc"]

check-requirements:
  #!/usr/bin/env bash
  if ! helm unittest --help >/dev/null 2>&1; then
    echo "helm unittest is not installed"
    echo "Check https://github.com/helm-unittest/helm-unittest?tab=readme-ov-file#install"
    exit 1
  fi
  if ! helm-docs --help >/dev/null 2>&1; then
    echo "helm-docs is not installed"
    echo "Check https://github.com/norwoodj/helm-docs?tab=readme-ov-file#installation"
    exit 1
  fi

test: check-requirements
  helm unittest charts/balanced-chart

docs: check-requirements
  helm-docs --values-file doc-values.yaml -s file --output-file VALUES.MD