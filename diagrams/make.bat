cd ..
start dart pub global run dcdg -b plantuml -o diagrams\classes.puml -e firebase_auth,firebase_database,dart::ui,dart::async,dart::core,firebase_options,flutter::src
start dart pub global run dcdg -b plantuml -o diagrams\exceptions.puml --is-a Exception
start dart pub global run dcdg -b plantuml -o diagrams\shared.puml --is-a StaticStrings,StaticColors,StaticMarkdown,SchemePlan
start dart pub global run dcdg -b plantuml -o diagrams\screens.puml --is-a DefaultScreen -e flutter::src,dart::ui,dart::async,widgets
start dart pub global run dcdg -b plantuml -o diagrams\widgets.puml --is-a PracticeButton,TheoryButton,MenuButton,Menu,ChapterButton -e flutter::src,dart::ui,dart::async
start dart pub global run dcdg -b plantuml -o diagrams\models.puml --is-a PracticeStorage,Practice,Theory,TheoryStorage,Auth,PlanStorage -e Exception,firebase_auth,firebase_database,startup::widgets,startup::screens
