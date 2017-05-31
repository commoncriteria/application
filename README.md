Application
===========

Protection Profile for Application Software


## Working Draft
[Essential Security Requirements (ESR)](http://common-criteria.rhcloud.com/application/output/application-esr.html)

[Protection Profile for Application Software](http://common-criteria.rhcloud.com/application/output/application-release.html)

## Release Version
[Protection Profile for Application Software v1.2](https://www.niap-ccevs.org/Profile/Info.cfm?id=394)

## Quickstart
To clone this project along with its _transforms_ submodule run:

````
  git clone --recursive git@github.com:commoncriteria/application.git
````
To pull updates from the upstream _transforms_ submodule and commit them run:
````
 git submodule update --remote transforms
 git add transforms
 git commit
````

[Help working with Transforms Submodule](https://github.com/commoncriteria/transforms/wiki/Working-with-Transforms-as-a-Submodule)

## Directory Description
* hooks - Contains scripts to be run when certain git events happen (I'm not sure how much these are used)
* input - Contains the 'meat' of the project. It's the input content (in XML form) that gets transformed to readable html.
* output - The output directory where the html is placed after transformation.
* output/images - The directory where images are stored
* transforms - Points to the transform subproject which is really a repository for resources shared amongst many CC projects.
* local - Resources that are specific to this project. They often modify or extend functionality from the transforms subproject.
* vetting-output-format - Files in this directory defines the format for output derived from evaluting an application.
