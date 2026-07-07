# sitesearch

OpenSearch-based search engine for the Giant Swarm documentation at https://docs.giantswarm.io/

**Homepage:** <https://github.com/giantswarm/sitesearch>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| name | string | `"sitesearch-app"` |  |
| image.registry | string | `"gsoci.azurecr.io"` |  |
| image.name | string | `"giantswarm/opensearch"` |  |
| image.tag | string | `"3.4.0"` |  |
| opensearch.clusterName | string | `"sitesearch"` |  |
| opensearch.nodeName | string | `"sitesearch-node-1"` |  |
| opensearch.singleNode | bool | `true` |  |
| opensearch.securityDisabled | bool | `true` |  |
| opensearch.forceCleanStart | bool | `false` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"650Mi"` |  |
| resources.requests.ephemeralStorage | string | `"512Mi"` |  |
| resources.limits.cpu | string | `"500m"` |  |
| resources.limits.memory | string | `"800Mi"` |  |
| resources.limits.ephemeralStorage | string | `"2Gi"` |  |
