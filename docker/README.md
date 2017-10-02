# Pootle translations

This folder contains 3 docker runners that enable creation of pootle translation environment

## Directory structure

This directory contains three subdirectories where each represents one component of **[Pootle](http://pootle.translatehouse.org/)** a web based localization server.

* **mysql** - scripts to create, though its name, mariadb server required by pootle 
* **redis** - in memory key-value server used by pootle
* **pootle** - ubuntu with pootle installed

All the containers refer to the ~/pootle directory where the essential container directories are linked between the container and host system.

> **Note:** This was tested on Ubuntu Linux 16.04 LTS as a host system, when running on Windows or MacOS X host to docker directory mapping shall be investigated. *At least on Windows it should working as -v //c/some/dir:/in/docker/dir.*

**mysql** and **redis** should be runnig prior to running the pootle server. When pootle containes is built with ``d01-build.sh`` or ``d01-buildDebug.sh`` the environment shall be initialized using ``d02-prep.sh`` (makes directories and copies files).

Next step is to launch the pootle container ``d03-run.sh`` into background (You can verify that it is running by obvious ``docker ps``).

In order to **get into** the container simply run ``d05-exec.sh`` which will provide you with bash inside container. The home directory in which you are move to is actually mapped to **~/pootle** on your host system. Thus you can easily exchange file with the container and translations via this directory.

> **Note:** You have to initialize the container prior to its use. 

### Initialization

As described in Pootle **[Instalation notes](http://docs.translatehouse.org/projects/pootle/en/stable-2.8.x/server/installation.html)** below is an excerpt that can be wisely copied and pasted into the shell.

```bash
# prepare the evironment for python modules instalation
# in theory as the docker provides the isolation this might be
# skipped, although it was not tested so far
virtualenv env

# load necessary environmental variables
source env/bin/activate

# install the installation dependencies
pip install --upgrade pip setuptools

# install the Pootle and Mysql deps
# ---
# to-do/check:
# offline: pip install -r requirements.txt --no-index --find-links file:///tmp/packages
# online: pip install -r requirements.txt
# ---
pip install --process-dependency-links Pootle[mysql]

# initialize the configuration
# might be skipped as 'pootle.conf' preprepared here in
# is provided to speed up config tweaking - by having a base
pootle init --db mysql --db-name pootledb --db-user pootle --db-host mysql

# copy the config instead of init (includes default password)
cp pootle.conf ~/pootle/env/

# prepares the database for translations
# but does not import the example projects
pootle initdb --no-projects

# create superuser aka admin of the pootle server (non-interactive)
pootle createsuperuser --username admin --no-input --email test@example.com
# verify email of the user without actually user clicking magic link
pootle verify_user admin

# set password for the user created above (!interactive!)
echo "please run 'pootle changepassword admin'"

# run the worker in background = & ampersand (rq = redis queue)
pootle rqworkers &

# and run the pootle server (Stop by Ctrl-C)
pootle runserver --insecure

# bring the rqworkers into foreground
fg
# stop the rqworkers with Ctrl-C
```

At this moment we are ready for the first translation project to be prepared.

Now you can start the translation loop (the pootle suggests to use FS plugin in order to use git - though it was not yet tested here).

### The preparation and loop

The loop is using [Traslation toolkit](http://docs.translatehouse.org/projects/translate-toolkit/en/latest/) to manipulate **po** files.

> **Note:** **po** files are the core of the pootle and actually has given **po**tle the name. In contrary the translator word uses **XLIFF** and **TM** (translation memory) in CAT (Computer Aided Translations). Which can also be exported/imported into this tools.
> Actually **po** files are string or message centered. Though there is certain extension that allows us to (ab)use the **po** file also for longer texts then the usual **printf** outputs. 

#### The preparation

Before you can start translating you have to run **A1-import.sh** once to make directories and files for translation.

Next step is to create project (will appear localised when browser is appripriately configure):

1. login as admin (superuser created above)
2. go to menu **Admin**
3. select tab **Projects**
4. in the right top part click **Add project**
5. the important part is the **Code** which should be equal to directory name used in import step
6. also **Source language** as appropriate
7. After clicking **Save** the rqworker will actually do the first import (similar to what **A2-import.sh** does)
8. Now you should be presented with new project to translate with all the string to translate.

> **Note:** The process of markdown to po files should be streamlined because txt2po and po2txt might not be the best for templated markdown. But it should not be that hard task.

#### The loop

* A1-import.sh - convert the original **orig-cs** resource from mediawiki/markdown into **po** files
* A2-import.sh - trigger the file to DB import (might be done by rqworker when project is created)

**...here do the translation...**

* B1-export.sh - complement to *A2-import.sh*, which synces the DB back to file system
* B2-export.sh - turn the exported **po** files into usable mediawiki/markdown

### Few things to consider

* [Translation Memory - reuse / ElasticSearch](http://docs.translatehouse.org/projects/pootle/en/stable-2.8.x/features/translation_memory.html) - tool for pootle (fuzzy matching in translations)
* [Git as storage plugin](http://docs.translatehouse.org/projects/pootle/en/stable-2.8.x/features/pootle_fs_install_plugins.html) - tool for pootle to use git directly
* [Machine Translation assistant - Google/Yandex/...](http://docs.translatehouse.org/projects/pootle/en/stable-2.8.x/features/machine_translation.html) - tool to help translator (Google paid Translator)
* [Translate5](https://www.translate5.net/) - the alternative, but for OpenTM2 requires Windows host :-( The Translate5 is PHP system, it requires openTMStermTagger is in java
* [Moses](http://www.statmt.org/moses/) - Statistical machine translation system
