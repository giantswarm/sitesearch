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
| architecture | string | `""` | Target CPU architecture for this workload. Empty imposes no constraint. `arm64` pins the pod to arm64 nodes, adding both the `kubernetes.io/arch` node selector and the toleration for the `kubernetes.io/arch=arm64:NoSchedule` taint that Giant Swarm arm64 node pools carry. Both are required, so this single value sets both. The OpenSearch image is published for amd64 and arm64, and Lucene index data is portable between them. |
| nodeSelector | object | `{}` | Node selector for pod scheduling. Merged with `architecture`, which wins for the `kubernetes.io/arch` key. |
| tolerations | list | `[]` | Tolerations for pod scheduling. Merged with the toleration that `architecture: arm64` adds. |
