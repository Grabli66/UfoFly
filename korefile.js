var solution = new Solution('UfoFly');
var project = new Project('UfoFly');
project.setDebugDir('build/linux');
project.addSubProject(Solution.createProject('build/linux-build'));
project.addSubProject(Solution.createProject('/home/grabli66/haxe/haxelib/kha/16,1,2'));
project.addSubProject(Solution.createProject('/home/grabli66/haxe/haxelib/kha/16,1,2/Kore'));
solution.addProject(project);
return solution;
