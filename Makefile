# vim: noexpandtab ts=4 sw=4

.DEFAULT_GOAL := plan

ENVVARS := env \
	DO_TOKEN="$$(pass digitalocean/token)" \
	OVH_APPLICATION_KEY="$$(pass ovhcloud/application_key)" \
    OVH_APPLICATION_SECRET="$$(pass ovhcloud/application_secret)" \
    OVH_CONSUMER_KEY="$$(pass ovhcloud/consumer_key)"
OCTODNS_COMMON := uv run octodns-sync --config-file octodns.yaml
OCTODNS_plan := $(OCTODNS_COMMON)
OCTODNS_apply := $(OCTODNS_COMMON) --doit

.PHONY: octodns-%
octodns-%:
	$(ENVVARS) sh -c '$(OCTODNS_$*)'

.PHONY: plan
plan: octodns-plan

.PHONY: apply
apply: octodns-apply
