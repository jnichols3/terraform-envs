# terraform-envs
Example of a terraform repo setup with multiple projects.

## base providers directories
The base directories provide a common place to configure all providers.  These directories are semantically versioned by whoever uses this repo to allow them flexibility to upgrade providers for individual projects or for the entire repo at the same time.  The projects then just symlink to the version and environment they want.  In the repo right now is just an AWS provider, but you can also add GCP, snowflake or any other 3rd party providers, alternate region AWS providers and so forth and only link what is needed in the individual projects.

## upgrading providers
Note that as the `atlantis.yaml` file is currently configured, changes to the base project directories do not trigger the autoplan feature in atlantis.  `when_modified` can be altered on a per-project basis, but in practice this has shown to be very cumbersome when a large number of projects are involved.  If a large terraform upgrade needs to be done en-masse, this flag can be added and then removed after to make things easier, but be careful- if there are 100's of projects as it can take a very long time for atlantis to process the pull request.  If you have an unforseen problem and need to fix one project it can take a very long time for atlantis to do this.

## terraform modules
The layout in this repo uses a centralized modules directory.  The included `atlantis.yaml` has an example for the ec2 project that uses a `when_modified: ["*.tf", "../modules/**.tf"]` setting to  trigger the pull request automation in Atlantis based on changes to the individual project or any of the modules.  

## environmental separation
The separation of environments (prod and stage) along with the parametrization of these environments is done via the directory structure, the simplest approach.  There are alternatives available using workspaces, tfvars, terragrunt, and others, but these add complexity in exchange for the de-duplication of some code.  Besides instance sizes, counts and other environmental sizing parameters, environment specific IAM permissions, CICD automation gates (i.e. only apply approved pull requests) can be achieved by modifying the environment specific directories.  For example, only allow developers to SSH into stage EC2 instances or delete s3 buckets via automation in staging only.

## sentinel
Basic sentinel policies to enforce tags and VM types are configured using common policies with varying levels of enforcement depending on the environment.

## new projects
There is a script, `new-tf.sh`, that you can give a project name and base provider type to and it will create a stage/prod project, link it to the base providers and setup.  A default `backend.tf` file is copied from the template project directory.  This can be modified with your specific backend and standardized across projects.  Note that atlantis.yaml or other CICD pull request automation needs to be updated or the script updated for your particular environment.
