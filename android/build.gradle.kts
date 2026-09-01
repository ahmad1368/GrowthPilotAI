allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// D: only has 5.41GB total and fills up mid-build, so the project's build/
// folder is a directory junction to C: (see setup notes) — this stays a
// project-relative path so Flutter's own tooling (which expects the APK at
// <project>/build/app/outputs/...) still finds it.
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
