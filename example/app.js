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
					media:e.media,
					caption:caption.value
				});
			} else {
				alert("Instagram is not installed!");
			}
		},
	});
});

window.open();