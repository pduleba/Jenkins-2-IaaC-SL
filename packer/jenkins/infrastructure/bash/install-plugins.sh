#!/usr/bin/env bash

echo "PHASE :: INIT"

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eu

PLUGIN_PATH=/var/lib/jenkins/plugins
OWNER=jenkins.jenkins
DEPENDENCY_CHECK_DEPTH_LIMIT=10

mkdir -p /var/lib/jenkins/plugins

isPluginInstalled() {
  if [[ -f ${PLUGIN_PATH}/${1}.hpi || -f ${PLUGIN_PATH}/${1}.jpi ]] ; then
    return 0
  else
    return 1
  fi
}

installPluginByName() {
  echo "Install ${1}"

  UPDATE_SITE=https://updates.jenkins-ci.org/latest

  if isPluginInstalled ${1} ; then
    echo "Install $1 :: installed"
  else
    echo "Install ${1} :: installing..."
    curl -L --silent --output ${PLUGIN_PATH}/${1}.hpi ${UPDATE_SITE}/${1}.hpi
    return 0
  fi
}

validatePluginsDirectory() {
  for PLUGIN_ARCHIVE in ${PLUGIN_PATH}/*.hpi ; do
    validatePluginArchive ${PLUGIN_ARCHIVE} ${DEPENDENCY_CHECK_DEPTH_LIMIT}
  done
}

validatePluginArchive() {
  echo "Validate ${1}"

  DEPENDENCY_CHECK_DEPTH=$2

  if  [[ ${DEPENDENCY_CHECK_DEPTH} -gt 0 ]] ; then

    ((DEPENDENCY_CHECK_DEPTH--))

    DEPENDENCIES=$( unzip -p ${1} META-INF/MANIFEST.MF | \
      tr -d '\r' | \
      sed -e ':a;N;$!ba;s/\n //g' | \
      grep -e "^Plugin-Dependencies: " | \
      awk '{ print $2 }' | tr ',' '\n' | \
      awk -F ':' '{ print $1 }' | tr '\n' ' ' )

    for DEPENDENCY_NAME in ${DEPENDENCIES} ; do
      echo "Validate ${1} :: dependency ${DEPENDENCY_NAME}"

      if isPluginInstalled ${DEPENDENCY_NAME} ; then
        continue
      else
        installPluginByName ${DEPENDENCY_NAME}
        validatePluginArchive "${PLUGIN_PATH}/${DEPENDENCY_NAME}.hpi" ${DEPENDENCY_CHECK_DEPTH}
      fi

    done
  else
    echo "Validate ${1} :: Too deep transitive dependency - skipping further check"
  fi
}

echo "PHASE :: INSTALL"
while read -r PLUGIN_NAME
do
    installPluginByName ${PLUGIN_NAME}
done < "/tmp/bash/install-plugins-list.txt"

echo "PHASE :: VALIDATE"
validatePluginsDirectory

echo "PHASE :: UPDATE OWNERSHIP"
chown ${OWNER} ${PLUGIN_PATH} -R

echo "PHASE :: COMPLETE"
