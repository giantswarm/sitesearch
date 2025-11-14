# Sitesearch

A component of docs. Sitesearch is an OpenSearch container used for indexing
and querying our documentation.

## App

The app/helm chart provided in the `helm` folder requires an additional
docker pull secret in the form

```yaml
apiVersion: v1
kind: Secret
metadata:
  namespace: docs
  name: sitesearch-pull-secret
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: REDACTED
```

This can be found at https://quay.io/organization/giantswarm?tab=robots in the details for the appropriate
robot account (a. g. `giantswarm+gollum`).

