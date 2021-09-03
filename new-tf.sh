#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Must supply 2 arguments: project-name and type (aws|eks|gcp)"
    exit -1
fi

if [ $2 != "aws" ] && [ $2 != "eks" ] && [ $2 != "gcp" ]
  then
    echo "Selected project type not supported (must be aws, eks or gcp)"
    exit -1
fi

echo "Creating new project $1 of type $2"

mkdir projects/$1
cd projects/$1
mkdir prod
mkdir stage

cd prod
cp ../../tf-template-project/prod/* .
if [ $2 == "aws" ]
  then
    ln -s ../../../base/0.9/prod/aws-vars.tf aws-vars.tf
    ln -s ../../../base/0.9/prod/aws.tf aws.tf
elif [ $2 == "eks" ]
then
  ln -s ../../../base/0.9/prod/eks-vars.tf eks-vars.tf
  ln -s ../../../base/0.9/prod/eks.tf eks.tf
elif [ $2 == "gcp" ]
then
  ln -s ../../../base/0.9/prod/gcp-vars.tf gcp-vars.tf
  ln -s ../../../base/0.9/prod/gcp.tf gcp.tf
fi
cd ../stage
cp ../../tf-template-project/stage/* .
if [ $2 == "aws" ]
  then
    ln -s ../../../base/0.9/stage/aws-vars.tf aws-vars.tf
    ln -s ../../../base/0.9/stage/aws.tf aws.tf
elif [ $2 == "eks" ]
then
  ln -s ../../../base/0.9/prod/eks-vars.tf eks-vars.tf
  ln -s ../../../base/0.9/prod/eks.tf eks.tf
elif [ $2 == "gcp" ]
then
  ln -s ../../../base/0.9/prod/gcp-vars.tf gcp-vars.tf
  ln -s ../../../base/0.9/prod/gcp.tf gcp.tf
fi

cd ../../

echo "New project created, you need to add it to atlantis.yaml or other CICD automation."
