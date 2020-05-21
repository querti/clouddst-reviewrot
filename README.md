An openshift deployment of review-rot

https://github.com/redhat-aqe/review-rot/pull/44

---

# Steps for initial project creation in OpenShift

First log in using the appropriate `oc login` command, then select or create
the OpenShift project that you will use.

## Creating the secrets

```
oc create secret generic clouddst-reviewrot-frontend \
--from-literal=WebHookSecretKey=$(openssl rand -base64 12)
```

```
oc create secret generic clouddst-reviewrot-backend \
--from-literal=WebHookSecretKey=$(openssl rand -base64 12) \
--from-literal=github-token=${GITHUB_TOKEN} \
--from-literal=gitlab-token=${GITLAB_TOKEN}
```

## Create the config

```
oc create configmap clouddst-reviewrot-config --from-file=./configuration.yaml
```

## Upload the template

```
oc create -f openshift-template.yaml
```

## Process the template

Specify the argument for the hostname to be used to access the frontend UI.

```
oc process clouddst-reviewrot-template -p FRONTEND_HOSTNAME=${FRONTEND_HOSTNAME} \
-p BACKEND_IMAGE=${BACKEND_IMAGE} | \
oc apply -f -
```

In the case of the internal Factory 2.0 deployment on the Upshift platform,
the full command is:

```
oc process clouddst-reviewrot-template \
-p FRONTEND_HOSTNAME=clouddst-reviews.cloud.paas.psi.redhat.com \
-p BACKEND_IMAGE=docker-registry.default.svc:5000/clouddst-reviewrot/clouddst-reviewrot-backend \
| oc apply -f -
```

# Steps for updating the project

## Updating the config

This is the most common update workflow and is performed when a change to
the ReviewRot config is necessary.

First delete the old config:

```
oc delete configmap/clouddst-reviewrot-config
```

Then recreate the new one:

```
oc create configmap clouddst-reviewrot-config --from-file=./configuration.yaml
```

The new config will be used when the cronjob gets run next.

## Updating the OpenShift template

First delete the old template

```
oc delete template/clouddst-reviewrot-template
```

Then recreate it with the new version

```
oc create -f openshift-template.yaml
```

And finally, process the template

```
oc process clouddst-reviewrot-template \
-p FRONTEND_HOSTNAME=clouddst-reviews.cloud.paas.psi.redhat.com \
-p BACKEND_IMAGE=docker-registry.default.svc:5000/clouddst-reviewrot/clouddst-reviewrot-backend \
| oc apply -f -
```
