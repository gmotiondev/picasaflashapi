import be.netdust.visual.UICore;
import be.netdust.visual.layout.skins.UISprite;
import be.netdust.visual.layout.styles.Style;
// mg
class be.netdust.visual.layout.styles.defaulttheme.Theme extends Style
{
	private static var _oI:Theme;
	private var _styles:Object = {};
	
	public static function initialize(  ) : Theme {
		if( _oI == null ) _oI = new Theme( "default" );
		return _oI;
	}
	
	private  function Theme( s:String ) {
		super()
		
		if ( !s ) {
			trace("error")
		} else {
			if( Style.registerTheme( s, this ) ) {
				_sID = s;
			};			
			
			UICore.UISKIN = UISprite.getInstance();
			Style._theme = this;
			initThemeStyle();
			initClassStyles();
		};
	}
	
	private function initThemeStyle() {
		embedFonts = false;
		
		var tf:Object = {fu:1, fo:1, fd:1, df:1, tu:1, to:1, td:1, dt:1};
		for (var i:String in tf) {
			this[i] = new Style({font:"Verdana",size:8});
		};
		var mp:Object = {margint:1, marginb:1, marginl:1, marginr:1, paddingt:1, paddingb:1, paddingl:1, paddingr:1};
		for (var i:String in mp) {
			this[i] = mp[i];
		};	
	}
	
	public function registerStyle( className:String, s:Style )
	{
		_styles[ className ] = s;
	}
	
	public function getStyle( className:String ) : Style
	{
		return _styles[ className ];
	}
		
	public function release( _sID:String ) : Void {
		Style.unregister( _sID );
	}
	
	private function initClassStyles()
	{
		var o:Object = {};
		var s:Object = {};
		var ss:Object = {};
		var sss:Object = {};
		
/** global formats **/
		var blueBold = {color:0x000099, bold:true};
		var blueBoldUnderLine = {color:0x000099, bold:true, underline:true};
		var blueBoldDisabled = {color:0x666666, bold:true};
		
		var blackDisabled = {color:0x666666};
		var blackBold = {bold:true};
		var blackBoldUnderLine = {bold:true, underline:true};
		var blackBoldDisabled = {color:0x666666, bold:true};
		
		var whiteBold = {color:0xFFFFFF, bold:true};
		var whiteBoldUnderLine = {color:0xFFFFFF, bold:true, underline:true};
		var whiteBoldDisabled = {color:0x666666, bold:true};
		
		var blackUnderLine = {underline:true};
		var blackUnderLineDisabled  = {color:0x666666, underline:true};

// STYLE OBJECT

/** style for Label class **/
		o = Style.newStyle("Label");
		o.skin = "LabelSkin";
		
/** style for TextInput class **/
		o = Style.newStyle("InputLabel");
		o.skin = "InputLabelSkin";
		o.setFormat("df", blackDisabled);
		o.setFormat("dt", blackDisabled);
		
/** style for TextArea class **/
		o = Style.newStyle("TextArea");
		o.skin = "InputTextSkin";
		o.setFormat("df", blackDisabled);
		o.setFormat("dt", blackDisabled);
		s = o.subStyle("content");
		s.skin = "";
				
		
/** style for Button class **/
		o = Style.newStyle("Button");
		o.skin = "buttonSkin";
		o.margin = 5;
		o.paddingl = 7;
		o.paddingr = 7;
		
		o.setFormat("fu", blueBold);
		o.setFormat("fd", blueBoldUnderLine);
		o.setFormat("fo", blueBoldUnderLine);
		o.setFormat("df", blueBoldDisabled);
		o.setFormat("tu", blueBold);
		o.setFormat("td", blueBoldUnderLine);
		o.setFormat("to", blueBoldUnderLine);
		o.setFormat("dt", blueBoldDisabled);
		
/** style for ScrollBar class **/
		o = Style.newStyle("ScrollBar");
		o.margin = 0;
		o.padding = 0;
		
		s = o.subStyle("track");
		s.skin = "ScrollerTrackSkin";
		s.margin = 0;
		s.padding = 1;
		
		ss = s.subStyle("thumb");
		ss.skin = "ScrollerThumbSkin";
		ss.margin = 0;
		ss.padding = 1;
		
		s = o.subStyle("min");
		s.skin = "ScrollerButtonSkin";
		s.margin = 1;
		ss = s.subStyle("H");
		ss.icon = "ScrollerLeftIcon";
		ss = s.subStyle("V");
		ss.icon = "ScrollerUpIcon";
		
		s = o.subStyle("plus");
		s.skin = "ScrollerButtonSkin";
		s.margin = 1;
		ss = s.subStyle("H");
		ss.icon = "ScrollerRightIcon";
		ss = s.subStyle("V");
		ss.icon = "ScrollerDownIcon";

		
// STYLE CONTAINERS
		o = Style.newStyle("Panel");
		o.skin = "PanelSkin";
		o.headerheight = 40;
		
/** style for TabPane class **/
		o = Style.newStyle("TabBox");
		o.skin = "TabBoxSkin";
		o.margint = 0;
		o.marginl = 5;
		o.marginr = 5;
		o.marginb = 5;
		o.padding = 2;
		
/** style for TabPanel class **/
		o = Style.newStyle("TabPanel");
		
/** style for Tab class **/
		o = Style.newStyle("Tab");
		o.setFormat("fu", blueBold);
		o.setFormat("fd", blueBoldUnderLine);
		o.setFormat("fo", blueBoldUnderLine);
		o.setFormat("df", blueBoldDisabled);
		o.setFormat("tu", blackBold);
		o.setFormat("td", blackBoldUnderLine);
		o.setFormat("to", blackBoldUnderLine);
		o.setFormat("dt", blackBold);
		o.skin = "TabSkin";
		o.margin = 0;
		o.padding = 0;

		
		
/** style for List class **/
		o = Style.newStyle("ListBox");
		o.skin = "ListSkin";
		o.padding = 2;
		
/** style for ListItem **/
		o = Style.newStyle("ListItem");
		o.skin = "ListNodeSkin";
		o.toggle = true;
		o.setFormat("fu", blueBold);
		o.setFormat("fd", blueBoldUnderLine);
		o.setFormat("fo", blueBoldUnderLine);
		o.setFormat("df", blueBoldDisabled);
		o.setFormat("tu", blackBold);
		o.setFormat("td", blackBoldUnderLine);
		o.setFormat("to", blackBoldUnderLine);
		o.setFormat("dt", blackBold);

/** style for List class **/
		o = Style.newStyle("Select");
		o.skin = "ButtonSkin";
		o.padding = 2;	

/** style for MenuBar class **/
		o = Style.newStyle("MenuBar");

		o = Style.newStyle("MenuPopup");
		o.skin = "MenuPopupSkin";
		o.padding = 10;
		o.margin = 0;	
		
		o = Style.newStyle("Menu");
		o.skin = "MenuSkin";
		o.padding = 0;
		o.margin = 0;	
		
		o = Style.newStyle("MenuItem");
		o.skin = "MenuItemSkin";

		
/** style for ComboBox class **/
		o = Style.newStyle("ComboBox");
		o.skin = "textInputSkin";
		s = o.subStyle("button");
		s.icon = "scrollDownIcon";
		s.align = "center";
		s.vAlign = "middle";
		s.skin = "buttonSkin";
		s = o.subStyle("content");
		s.skin = "";
		s = o.subStyle("textinput");
		s.skin = "";
		s = o.subStyle("list");
		s.defaultProperties = {itemClass:"Button", itemStyle:"ComboBoxItem", itemDim:1};
		s.multipleSelection = false;
		s.skin = "defaultSkin";
		
		o = Style.newStyle("ComboBoxItem");
		o.skin = "ComboBoxSkin";
		o.toggle = true;
		o.btnOffset = 0;
		o.defaultProperties = {itemClass:"Button", itemStyle:"ComboBoxItem", itemDim:1};
		s = o.subStyle("H");
		s.align = "center";
		s.vAlign = "bottom";
		s.textRotation = -90;
		s = o.subStyle("V");
		s.align = "left";
		s.vAlign = "middle";
		s.textRotation = 0;
		
		
/** style for Slider class **/
		o = Style.newStyle("Slider");
		o.padding = 10;
		o.track_padding = 1;
		o.thumb_padding = -7;
		o.but_padding = -5;
		o.cue_padding = 0;
		o.but_spacing = 6;
		o.track_spacing = 8;
		o.cuepoint_dim = 1;
		o.labelstick_dim = 1;
		o.stick_padding = 0;
		o.label_padding = 0;
		
		s = o.subStyle("track");
		s.skin = "progressTrackSkin";
		
		s = o.subStyle("trackMinus");
		s.skin = "sliderTrackMinusSkin";
		s.autoRepeat = true;
		
		s = o.subStyle("trackPlus");
		s.skin = "sliderTrackPlusSkin";
		
		s = o.subStyle("butMinus");
		s.skin = "buttonSkin";
		s.autoRepeat = true;
		ss = s.subStyle("H");
		ss.icon = "scrollLeftIcon";
		ss = s.subStyle("V");
		ss.icon = "scrollUpIcon";
		
		s = o.subStyle("butPlus");
		s.skin = "buttonSkin";
		s.autoRepeat = true;
		ss = s.subStyle("H");
		ss.icon = "scrollRightIcon";
		ss = s.subStyle("V");
		ss.icon = "scrollDownIcon";
		
		s = o.subStyle("cuePoint");
		s.skin = "darkGreySkin";
		
		s = o.subStyle("LabelButton");
		s.setFormat("fu", blueBold);
		s.setFormat("fd", blueBoldUnderLine);
		s.setFormat("fo", blueBoldUnderLine);
		s.setFormat("df", blueBoldDisabled);
		
		s = o.subStyle("LabelStick");
		s.skin = "darkGreySkin";
		
/** styles for thumb class **/
		o = Style.newStyle("Thumb0");
		o.skin = "buttonSkin";
		s = o.subStyle("H");
		s.icon = "scrollGripHIcon";
		s = o.subStyle("V");
		s.icon = "scrollGripVIcon";

		o = Style.newStyle("Thumb1");
		s = o.subStyle("H");
		s.icon = "sliderGripHIcon";
		s.skin = "sliderThumbHs1Skin";
		s = o.subStyle("V");
		s.icon = "sliderGripVIcon";
		s.skin = "sliderThumbVs1Skin";
		
		o = Style.newStyle("Thumb2");
		s = o.subStyle("H");
		s.icon = "sliderGripHIcon";
		s.skin = "sliderThumbHs2Skin";
		s = o.subStyle("V");
		s.icon = "sliderGripVIcon";
		s.skin = "sliderThumbVs2Skin";
		
		o = Style.newStyle("Thumb3");
		s = o.subStyle("H");
		s.icon = "sliderGripHIcon";
		s.skin = "sliderThumbHs3Skin";
		s = o.subStyle("V");
		s.icon = "sliderGripVIcon";
		s.skin = "sliderThumbVs3Skin";
		
		o = Style.newStyle("Thumb4");
		s = o.subStyle("H");
		s.icon = "sliderGripHIcon";
		s.skin = "sliderThumbHs4Skin";
		s = o.subStyle("V");
		s.icon = "sliderGripVIcon";
		s.skin = "sliderThumbVs4Skin";
		

		
/** style for ProgressBar class **/
		o = Style.newStyle("ProgressBar");
		o.padding = 0;
		o.track_padding = 1;
		
		s = o.subStyle("track");
		s.skin = "progressTrackSkin";
		
		s = o.subStyle("trackMinus");
		ss = s.subStyle("H");
		ss.skin = "progressTrackHSkin";
		ss = s.subStyle("V");
		ss.skin = "progressTrackVSkin";
		
/** style for HBox class **/
		o = Style.newStyle("HBox");
		
/** style for VBox class **/
		o = Style.newStyle("VBox");
		
/** style for Canvas class **/
		o = Style.newStyle("Canvas");
		
/** style for ScrollCanvas class **/
		o = Style.newStyle("ScrollCanvas");
		o.skin = "defaultSkin";
		


		

		
/** style for radiobutton class **/
		
		o = Style.newStyle("RadioButton");
		o.iconpos = "left-mid";
		o.icon = "RadioButtonIcon";
		o.align = "left";
		o.setFormat("fu", blueBold);
		o.setFormat("fd", blueBoldUnderLine);
		o.setFormat("fo", blueBoldUnderLine);
		o.setFormat("df", blueBoldDisabled);
		o.setFormat("tu", blackBold);
		o.setFormat("td", blackBoldUnderLine);
		o.setFormat("to", blackBoldUnderLine);
		o.setFormat("dt", blackBold);
		
/**  style for checkbox class **/
		o = Style.newStyle("CheckBox");
		o.icon = "CheckBoxIcon";
		o.toggle = true;
		o.setFormat("fu", blueBold);
		o.setFormat("fd", blueBoldUnderLine);
		o.setFormat("fo", blueBoldUnderLine);
		o.setFormat("df", blueBoldDisabled);
		o.setFormat("tu", blackBold);
		o.setFormat("td", blackBoldUnderLine);
		o.setFormat("to", blackBoldUnderLine);
		o.setFormat("dt", blackBoldDisabled);
				
/** style for videoholder class **/
		o = Style.newStyle("VideoHolder");
		o.skin = "tabBodySkin";
		
/** style for video class **/
		o = Style.newStyle("Video");
		o.skin = "defaultSkin";
	
	
/** style for transparent class **/
		o = Style.newStyle("Transparent");
		o.skin = "";
		
/** style for Border class **/
		o = Style.newStyle("Border");
		o.skin = "defaultSkin";
		
/** style for PlaceHolder **/
		o = Style.newStyle("PlaceHolder");
		o.skin = "transSkin";
		o.align = "center";
		o.vAlign = "middle";
		
/** style for PlaceHolder **/
		o = Style.newStyle("ToolTip");
		o.backgroundAlpha = 100;
		o.backgroundColor = 0xF8F8CB;
		o.shadowAlpha = 20;
		o.margin = 4;
		o.setFormat("fu", blackBold);		
		
		s = o.subStyle( "border" );
		s.color = 0x999999;
		
	}
}
