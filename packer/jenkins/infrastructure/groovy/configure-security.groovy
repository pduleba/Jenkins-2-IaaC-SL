#!groovy

import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

def realm = new HudsonPrivateSecurityRealm(false)
realm.createAccount('USERNAME','PASSWORD')
instance.setSecurityRealm(realm)

def fullAccessStrategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(fullAccessStrategy)
instance.save()