#!groovy

import jenkins.model.Jenkins
import jenkins.security.s2m.*

Jenkins jenkins = Jenkins.getInstance()

jenkins.setSlaveAgentPort(-1)

HashSet<String> protocols = new HashSet<>(jenkins.getAgentProtocols())
protocols.removeAll(Arrays.asList("JNLP3-connect", "JNLP2-connect", "JNLP-connect", "CLI-connect"))
jenkins.setAgentProtocols(protocols)
jenkins.save()
