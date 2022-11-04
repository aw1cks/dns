# vim: noexpandtab ts=4 sw=4

.DEFAULT_GOAL := plan



VENV_NAME := venv
ACTIVATE_VENV := . $(VENV_NAME)/bin/activate

.PHONY: venv
venv:
	python3 -m venv venv
	sh -c '$(ACTIVATE_VENV) && pip install -r requirements.txt'



ENVVARS := env \
	DO_TOKEN="$$(pass digitalocean/token)" \
	GCORE_TOKEN="$$(pass gcore/apikey)"
OCTODNS_COMMON := $(ACTIVATE_VENV) && octodns-sync --config-file octodns.yaml
OCTODNS_plan := $(OCTODNS_COMMON)
OCTODNS_apply := $(OCTODNS_COMMON) --doit

.PHONY: octodns-%
octodns-%: venv
	$(ENVVARS) sh -c '$(OCTODNS_$*)'



.PHONY: plan
plan: octodns-plan

.PHONY: apply
apply: octodns-apply
