# Example setup of GKE autopilot cluster

This directory contains example files for setting up kubernetes clusters 
on GKE (Google Kubernetes Engine) with the k-pipe pipeline operator 
installed (based on the [gke-autopilot terraform module](https://github.com/k-pipe/terraform-module-gke-autopilot)). 

## Description of files

| File             | Description                                                                                                                                             |
|------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| apply.sh         | Shell script to run the provisioning                                                                                                                    |
| backend.tf       | Terraform file to specify using google cloud storage for storing the state (the parameter `bucket` is omitted because it will be set over command line) |
| main.tf          | Terraform main file, modify this to specify the kubernernetes clustes you would like to have (together with the version of the pipeline operator)       |
| terraform.tfvars | Values for variables (modify this to specify network parameters in case you do not want to use the default network)                                     |
| variables.tf     | Terraform file to define variables (for some of them the value will be specified over commandline, the rest will be provided in `interraform.tfvars`)     |

## Prerequisites

You need to have access to (and sufficient permissions on) a GCP project (https://console.cloud.google.com/). You must
have an active GCP configuration (set it up using `gcloud init`) and activated credentials (`gcloud auth application-default login`).

Furthermore you need the tool `terraform` installed (https://developer.hashicorp.com/terraform/install).

## Usage

Download the files in this folder to a local directory:

```
git clone https://github.com/k-pipe/terraform-module-gke-autopilot.git
cd terraform-module-gke-autopilot
git sparse-checkout set --no-cone example
cd example
```

To install the clusters specified in `main.tf` in the default project and the default zone (sepcified via `gcloud init`), 
simply run the provided script (in the folder where it is placed):

```
sh apply.sh
```

In order to specify a different gcp project and zone (or if you have no defaults specified) use command line 
arguments as follows:

```
sh apply.sh GGP_PROJECT_ID GCP_ZONE
```

Example: `sh apply.sh my-first-gcp-project europe-west3-b`

After the cluster is created, you may use this command
```
gcloud container clusters get-credentials processing-dev --zone europe-west3
```
in order to get the credentials to use `kubectl`.
As next step you may define and run pipelines following 
the getting started instructions of the [helm chart](https://helm.k-pipe.cloud/) (start 
at section `Define a pipeline`).

**NOTE:** We recommend to commit the 5 files used for provisioning into a git repository, so
that provisioning can be reproduced at a later time and changes to the configuration may be tracked.