uses java.time.ZoneId

uses java.time.ZoneOffset
uses java.time.ZonedDateTime

uses com.kylemoore.ge.api.GradleBuildExporter

var jan10 = ZonedDateTime.of(2017, 1, 10, 0, 0, 0, 0, ZoneOffset.UTC)
  
var builds = GradleBuildExporter.make
  .since(jan10)
  .excluding("jqjygupj7bq7m") //this nasty build has 562,697 events
  .withHostname("kmoore-linux")
  .withUsername("kmoore")
  .withOsFamily("linux")
  .withCustomValue("studio-version", "1.1.x")
  .withTag("foo")
  //.withDebugLogging()
  .execute()

builds.each(\build -> print("Build ${build.publicBuildId} compiled Java in ${build.JavaCompilationTime}, Gosu in ${build.GosuCompilationTime}. Link -> ${build.URL}"))

print(builds.first().UploadedTime)

var after1pm = ZonedDateTime.of(2017, 1, 10, 13, 0, 0, 0, TimeZone.getTimeZone("PST").toZoneId())
print(builds.where(\build -> build.UploadedTime > after1pm).Count)