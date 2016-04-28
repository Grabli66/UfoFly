var project = new Project('UfoFly');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addSources('Sources/Engine');
project.addSources('Sources/Engine/Core');
project.addSources('Sources/GameScene');
return project;
