package android

// Global config used by Fusion soong additions
var FuseConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.fuse.hardware",
	},
}
