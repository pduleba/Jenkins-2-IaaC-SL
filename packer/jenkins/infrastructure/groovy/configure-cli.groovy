#!groovy

import jenkins.model.Jenkins

Jenkins jenkins = Jenkins.getInstance()

jenkins.CLI.get().setEnabled(false)
jenkins.save()