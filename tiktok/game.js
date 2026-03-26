
function createCanvas() {
	const systemInfo = tt.getSystemInfoSync();
	const canvas = tt.createCanvas();
    canvas.width = systemInfo.screenWidth * systemInfo.pixelRatio;
    canvas.height = systemInfo.screenHeight * systemInfo.pixelRatio;
	return canvas;
}

function loadLauncher() {
	const systemInfo = tt.getSystemInfoSync();
	console.log("systemInfo.SDKVersion", systemInfo.SDKVersion)
	if (systemInfo.SDKVersion < "3.95.0") {
		console.warn("using embed godot launcher.")
		return require("./godot.launcher.js")
	} else {
		return requirePlugin("GodotPlugin/index.js");
	}
}

function main() {
	const launcher = loadLauncher();

	launcher.start({
		canvas: createCanvas(),
		config: require('./godot.config.js')
	});
}

main();

/* keep this lines
tt.navigateToScene
*/

