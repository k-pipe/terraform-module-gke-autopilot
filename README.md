
# Terraform module for setting up a GKE autopilot cluster

This terraform module sets up a GKE kubernetes cluster in autopilot mode using the [helm chart for the k-pipe pipeline operator](https://helm.k-pipe.cloud/).

## Components

The terraform module sets up the following ressources:
 * A service account used to operate the cluster (its name is chosen to be identical to the cluster name)
 * Some minimally required roles assigned to the service account
 * A kubernetes cluster in autopilot mode with specified network settings
 * A helm chart release of the k-pipe operator (in the specified version)

## Inputs

| Name             | Description                                                                           |
|------------------|---------------------------------------------------------------------------------------|
| project_id       | the gcp project in which the k8s cluster will reside                                  |
| region           | the gcp region into which the k8s cluster will be placed                              |
| zone             | the gcp zone in which the execution pods will be running (must be in provided region) |
| cluster_id       | name of the k8s cluster                                                               |
| operator_version | version of the pipeline operator to be used                                           |
| network          | network to be used for k8s cluster                                                    |
| subnetwork       | subnetwork to be used for k8s cluster                                                 |

## Example

An example on how to use this terraform module in order to setup one or multiple GKE clusters for pipeline 
processing can be found in [subfolder example](./example) (simply download 
all files in this folder and follow the instructions in the file [README.md](./example/README.md) .
