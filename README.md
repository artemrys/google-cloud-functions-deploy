# Bitbucket Pipelines Pipe: Google Cloud Function Deploy

Pipe to deploy a function to [Google Cloud Function][gcf].

## YAML Definition

Add the following snippet to the script section of your `bitbucket-pipelines.yml` file:

```yaml
- pipe: docker://artemrys/google-cloud-functions-deploy:latest
  variables:
    KEY_FILE: '<string>'
    PROJECT: '<string>'
    FUNCTION_NAME: '<string>'
    ENTRY_POINT: '<string>'
    RUNTIME: '<string>'
    # MEMORY: '<string>'  [Optional]
    # TIMEOUT: '<string>'  [Optional]
    # EXTRA_ARGS: '<string>' [Optional]
    # DEBUG: '<string>'  [Optional]
```

## Variables

| Variable                   | Usage                                                |
| ----------------------------- | ---------------------------------------------------- |
| KEY_FILE (*)                  |  Key file for a [Google service account](https://cloud.google.com/iam/docs/creating-managing-service-account-keys). |
| PROJECT (*)                   |  The Project ID of the project that owns the app to deploy. |
| FUNCTION_NAME (*)             |  The name of the function in Google Cloud Function. |
| ENTRY_POINT (*)               |  The deployed Cloud Function will use a function named `ENTRY_POINT` in the source file. |
| RUNTIME (*)                   |  The runtime of the Cloud Function. |
| MEMORY                        |  The memory limit of the Cloud Function. |
| TIMEOUT                       |  The timeout of the Cloud Function. |
| EXTRA_ARGS                    |  Extra arguments to be passed to the CLI. |
| DEBUG                         |  Turn on extra debug information. Default `false`. |

_(*) = required variable._


## Prerequisites

* An IAM user is configured with sufficient permissions to perform a deployment of your application using gcloud.
* You have [enabled APIs and services](https://cloud.google.com/service-usage/docs/enable-disable) needed for your application.


## Examples

### Basic example:

```yaml
- pipe: docker://artemrys/google-cloud-functions-deploy:latest
  variables:
    KEY_FILE: $KEY_FILE
    PROJECT: 'my-project'
    FUNCTION_NAME: 'hello_world'
    ENTRY_POINT: 'hello_world'
    RUNTIME: 'python37'
```

### Advanced example:

```yaml
- pipe: docker://artemrys/google-cloud-functions-deploy:latest
  variables:
    KEY_FILE: $KEY_FILE
    PROJECT: 'my-project'
    FUNCTION_NAME: 'hello_world'
    ENTRY_POINT: 'hello_world'
    RUNTIME: 'python37'
    MEMORY: '256MB'
    TIMEOUT: '60'
    EXTRA_ARGS: '--logging=debug'
```

## Supports
If you would like help with this pipe, or you have an issue or feature request, go to [Bitbucket repo][bitbucket_repo].

If you are reporting an issue, please include:

* relevant logs and error messages
* steps to reproduce

## License
Copyright (c) 2018 Atlassian and others.
Apache 2.0 licensed, see [LICENSE.txt](LICENSE.txt) file.

[gcf]: https://cloud.google.com/functions
[bitbucket_repo]: https://bitbucket.org/ArtemRys/google-cloud-functions-deploy
