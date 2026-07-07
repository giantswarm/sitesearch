# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
