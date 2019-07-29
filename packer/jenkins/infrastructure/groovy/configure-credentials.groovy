import jenkins.model.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*

domain = Domain.global()
store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

gitCredentials = new UsernamePasswordCredentialsImpl(
  CredentialsScope.GLOBAL,
  "git", "Git credentials",
  "USERNAME",
  "PASSWORD"
)

store.addCredentials(domain, gitCredentials)
