package android

// Global config used by Fusion soong additions
var HornbillConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.hornbill.hardware",
	},
}
