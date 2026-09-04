# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Add a `helm-unittest` suite covering the `sitesearch.podScheduling` helper (13 cases): the empty default, arm64 and amd64, merging with explicit `nodeSelector`/`tolerations`, the conflict failure, pinning to arm64 through `nodeSelector` alone, and the toleration-coverage cases. Run it with `make helm-unittest`. Local only for now, since chart unit tests belong in the generated workflow set rather than a hand-written per-repo workflow. The helper is copied per chart because there is no shared library chart, so these tests are what stop the copies drifting.
- Add `architecture` value (`""` | `amd64` | `arm64`) to pin the workload to a CPU architecture, plus `nodeSelector` and `tolerations` passthrough values (the pod spec previously had no scheduling fields at all). Setting `arm64` renders both the `kubernetes.io/arch` node selector and the toleration for the `kubernetes.io/arch=arm64:NoSchedule` taint that Giant Swarm arm64 node pools carry. Both are required, and setting only one fails in a different, non-obvious way, so a single value drives both. Defaults to `""`, which renders nothing, so output is unchanged for existing users. The logic lives in the `sitesearch.podScheduling` helper and merges with the explicit values. The toleration is derived from the effective `kubernetes.io/arch` selector, so pinning to arm64 through `nodeSelector` alone is as safe as through `architecture`, and is skipped when an explicit toleration already covers the taint. A `nodeSelector` that sets `kubernetes.io/arch` to something other than `architecture` is a contradiction and fails the render. Follows the convention introduced in [hello-world-app#276](https://github.com/giantswarm/hello-world-app/pull/276).

### Changed

- Raise default `ephemeral-storage` (requests 100Mi→512Mi, limits 500Mi→2Gi). OpenSearch's logs and plugins dirs are `emptyDir` (ephemeral), and the bundled plugins + logs exceed 500Mi, causing the pod to be evicted with `ephemeral local storage usage exceeds the total limit`.
- Lower OpenSearch `MaxRAMPercentage` from 80 to 50 so the JVM heap leaves enough headroom for off-heap/Lucene memory within the container limit (was OOMKilled at 80%).
- Prepare chart for use with Flux OCIRepository + HelmRelease.
- Sanitize `.Chart.Version` in labels with `commit` and `branch` helpers.
- Use common labels and selectors consistently on all resources.
- Use binary suffix (`Mi`) for memory resource values.
- Add `ephemeral-storage` resource requests and limits (Kyverno policy compliance).
- Enable `replace-app-version-with-git` in ABS config.
- Add `helm.sh/resource-policy: keep` to the OpenSearch index PVC so it survives a release uninstall (protects the search index from accidental HelmRelease deletion).

### Removed

- Remove legacy `app` label from resources.
- Remove unused `giantswarm.io/managed-by` and `giantswarm.io/service-type` labels.
- Remove unused `global.podSecurityStandards` config (PSP is no longer supported).

[Unreleased]: https://github.com/giantswarm/sitesearch/compare/v1.3.8...HEAD
