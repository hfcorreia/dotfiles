# Env variables
export ANDROID_HOME="/usr/local/opt/android-sdk"
export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
export JRUBY_OPTS="-J-XX:+CMSClassUnloadingEnabled -J-XX:+UseConcMarkSweepGC -J-XX:+UseParNewGC -J-XX:MaxPermSize=256m -J-Xms1024m -J-Xmx1024m -Xcompile.invokedynamic=false"

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 

# Use vim as default editor
export EDITOR="vim"
