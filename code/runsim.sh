#export JAVA_OPTS="-Xprof -server -Xms1g -Xmx1g"
export JAVA_OPTS="-d64 -server -Xms1g -Xmx1g"

CP=""
for f in lib/*.jar
do
CP=$CP:${f}
done

scala -nocompdaemon -cp $CP sim.scala
scala -nocompdaemon -cp $CP clts.scala
