Sitesearch
----------

A component of docs. Sitesearch is a elasticsearch container used for indexing
and querying our documentation.


Kubernetes manifests
--------------------

Sitesearch is deployed to the `docs` namespace in g8s.

It depends on a registry pull secret being present in that namespace.
An example registry-pull-secret is available in the docs repo.