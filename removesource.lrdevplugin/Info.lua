--[[----------------------------------------------------------------------------
Info.lua
Export Remove Source 
--------------------------------------------------------------------------------
Plugin to allow the removal of source files as a post-processing step after export is complete
------------------------------------------------------------------------------]]

return {

	LrSdkVersion = 3.0,
	LrSdkMinimumVersion = 1.3, 

	LrPluginName = LOC "$$$/SDK/ExportRemoveSource/Sample=Export Remove Source",
	LrToolkitIdentifier = 'com.adobe.lightroom.sdk.export.exportremovesource',
	
	LrExportFilterProvider = {
		title = LOC "$$$/SDK/ExportRemoveSource/Sample=Export and Remove Source", 
		file = 'ExportRemoveSource.lua', 
		id = "removesource",  -- unique identifier for export filter
	},

	VERSION = { major=1, minor=1, revision=0, build=1, },

}
