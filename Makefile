# vim: expandtab ts=4 sw=4
.PHONY: venv
venv:
	python3 -m venv venv
	sh -c 'source venv/bin/activate && pip install -r requirements.txt'


OCTODNS_ARGS := --config-file octodns.yaml
ENVVARS := \
    CLOUDFLARE_TOKEN="$$(pass cloudflare/apikey)" \
    CLOUDFLARE_EMAIL="$$(pass cloudflare/email)" \
    GCORE_TOKEN="$$(pass gcore/apikey)"
.PHONY: plan
plan:
	env $(ENVVARS) sh -c 'source venv/bin/activate && octodns-sync $(OCTODNS_ARGS)'
.PHONY: apply
apply:
	env $(ENVVARS) sh -c 'source venv/bin/activate && octodns-sync $(OCTODNS_ARGS) --doit'
