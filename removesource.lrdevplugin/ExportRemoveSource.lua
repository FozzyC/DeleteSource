--[[----------------------------------------------------------------------------

ExportFilterProvider.lua
metaExportFilter Sample Plugin
ExportFilterProvider for the Metadata Export Filter sample plugin

Defines the dialog section to be displayed in the Export dialog and provides the
filter process before the photos are exported.

--------------------------------------------------------------------------------

------------------------------------------------------------------------------]]

local LrView = import 'LrView'
local LrFileUtils = import 'LrFileUtils'
local bind = LrView.bind

--local LrLogger = import 'LrLogger'
--local myLogger = LrLogger( 'lightroomLogger' )
--myLogger:enable( "logfile" )


--------------------------------------------------------------------------------
-- This function will create the section displayed on the export dialog
local function sectionForFilterInDialog( f, propertyTable )
	
	return {
		title = LOC "$$$/SDK/ExportRemoveSource/SectionTitle=Remove Source Files After Export",
		f:row {
			spacing = f:control_spacing(),
			f:static_text {
				title = "Remove Source Files",
			},
			
			f:checkbox{
				value = bind 'sourceremoval'
			},
		},
		f:row {
			spacing = f:control_spacing(),
			f:static_text {
				title = "Removes the original file from disk after successful export - use with caution",
			},
			
		}
	}
end

--------------------------------------------------------------------------------
-- presets here
local exportPresetFields = {
	{ key = 'sourceremoval', 	default = false }
}


--------------------------------------------------------------------------------
local function postProcessRenderedPhotos(functionContext,filterContext)
	for sourceRendition, renditionToSatisfy in filterContext:renditions(
renditionOptions ) do
	-- Wait for the upstream task to finish its work on this photo.
	
	local success, pathOrMessage = sourceRendition:waitForRender()
	if success then
	
		if filterContext.propertyTable.sourceremoval then
		--myLogger:trace(exportPresetFields.sourceremoval)
		if LrFileUtils.isDeletable(renditionToSatisfy.photo:getRawMetadata( 'path' )) then
			--myLogger:trace(renditionToSatisfy.photo:getRawMetadata( 'path' ))
			--delete the file
			LrFileUtils.delete(renditionToSatisfy.photo:getRawMetadata( 'path' ))
		end
		end
	end
	end
end


return {
	exportPresetFields = exportPresetFields,
	sectionForFilterInDialog = sectionForFilterInDialog,
	postProcessRenderedPhotos = postProcessRenderedPhotos,
}
