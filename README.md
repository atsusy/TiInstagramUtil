Hooks Instagram from Titanium Mobile app
===========================================

INSTALL MODULE
--------------------

1. Run `build.py` which creates your distribution
2. Copy jp.msmc.tiinstagramutil-iphone-1.0.zip into your app project of root directory
3. Rebuild the project

REGISTER MODULE
---------------------

Register your module with your application by editing `tiapp.xml` and adding your module.
Example:

	<modules>
		<module version="1.0">jp.msmc.tiinstagramutil</module>
	</modules>

When you run your project, the compiler will know automatically compile in your module
dependencies and copy appropriate image assets into the application.

USING MODULE
-------------------------

To use your module in code, you will need to require it. 

For example,

	var instagramUtil = require('jp.msmc.tiinstagramutil');
	var window = Ti.UI.createWindow({});
	
	var caption = Ti.UI.createTextField({
		top:50,
		width:240,
		height:40,
		hintText:'Enter caption here',
		borderStyle:Ti.UI.INPUT_BORDERSTYLE_ROUNDED,
	});
	window.add(caption);
	
	var button = Ti.UI.createButton({
		title:'Open photo gallery',
		width:Ti.UI.SIZE,
		height:32
	});
	window.add(button);
	
	button.addEventListener('click', function(e){
		Ti.Media.openPhotoGallery({
			allowEditing:true,
			mediaTypes:[Ti.Media.MEDIA_TYPE_PHOTO],
			success:function(e){
				if(instagramUtil.isInstalled){
					instagramUtil.openPhoto({
						media:e.media, // media must be blob
						caption:caption.value
					});
				} else {
					alert("Instagram is not installed!");
				}
			},
		});
	});
	
MODULE REFERENCE
-------------------------

*	Properties

Name 			| Description
:------------	| :-------------
isInstalled 	| true - Instagram is installed. false - Instagram is *NOT* installed.

*	Functions

Name 				| Description
:---------------	| :-------------
openPhoto(args)	| Open Instagram app. 
					| args.media(blob) : passing this image to Instagram
					| args.caption(string) : passing this text to Instagram
	
	
LICENSE
-------------------------
MIT License

