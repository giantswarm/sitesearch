import logging

import pykube
from pytest_helm_charts.clusters import Cluster
import pytest

logger = logging.getLogger(__name__)


@pytest.mark.smoke
def test_api_working(kube_cluster: Cluster) -> None:
    """Placeholder smoke test.

    The smoke step is skipped via .ats/main.yaml because the sitesearch chart
    deploys a stateful OpenSearch workload that cannot reach readiness on a bare
    kind cluster within the smoke timeout. This test only asserts the cluster
    API is reachable, and exists so the tests/ats directory is present if the
    smoke step is ever re-enabled.
    """
    assert kube_cluster.kube_client is not None
    assert len(pykube.Node.objects(kube_cluster.kube_client)) >= 1
