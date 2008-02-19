import be.netdust.visual.UICore;
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.layout.skins.UIBorder;

class be.netdust.visual.layout.styles.bordertheme.Theme
{
	private static var _oI:Theme;	
	
	public static function initialize(  ) : Theme {
		if( _oI == null ) _oI = new Theme( "border" );
		return _oI;
	}
	
	/**
	* inherit default style settings from this theme
	* @param	s, the newly created style
	* @return  	a style with the themes default settings
	*/
	public function inheritStyle( s:Style ) : Style {
		for(var i:String in this) {
			if (!(this[i] instanceof Style) ) {
				s[i] = this[i];
			}
		};		
		return s;
	};
	
	public function registerStyle( className:String, s:Style )
	{
		_styles[ className ] = s;
	}
	
	public function getStyle( className:String ) : Style
	{
		return _styles[ className ];
	}
	
	//
	
	private function Theme( s:String ) {
		
		if ( !s ) {
			trace("error")
		} else {
			
			if( Style.registerTheme( s, this ) ) {
				 _sID = s;
			};			
			
			UICore.UISKIN = UIBorder.getInstance();
			initThemeStyle( );
		};
	}
	
	private function initThemeStyle(  ) 
	{		
		// init default textformat styles
		for (var i:String in Theme.InheritableStyle) {
			this[i] = new Style( {font:"kroeger", size:8} );
		};
		
		embedFonts = true;
		width = height = 0;		
		backgroundAlpha = 0;
		backgroundImage = "";
		backgroundColor = 0xFFFFFF;		
		backgroundPosition = {x:0,y:0};
		marginLeft = marginRight = marginTop = marginBottom = 0;
		paddingLeft = paddingRight = paddingTop = paddingBottom = 0;		
		cornerBottomRight = cornerBottomLeft = cornerTopRight = cornerTopLeft = 0;
		borderBottomWidth = borderTopWidth = borderRightWidth = borderLeftWidth = 0;
		borderBottomAlpha = borderTopAlpha = borderRightAlpha = borderLeftAlpha = 0;
		borderBottomColor = borderTopColor = borderRightColor = borderLeftColor = 0xFFFFFF;		
		

		initClassStyles();
	}
	
	private function initClassStyles()
	{
		var o:Object = {};
		var s:Object = {};
		var ss:Object = {};
		
		
/** global text format objects **/
		var green:Object = {color: 0x99CC33, bold:false, underline:false};
		var greenBold:Object = {color: 0x99CC33, bold:true, underline:false};
		var greenUnderLine:Object = {color:0x99CC33, bold:false, underline:true};
		var greenBoldUnderLine:Object = {color:0x99CC33, bold:true, underline:true};		
		
		var magenta:Object = {color: 0xD40073, bold:false, underline:false};
		var magentaBold:Object = {color: 0xD40073, bold:true, underline:false};
		var magentaUnderLine:Object = {color:0xD40073, bold:false, underline:true};
		var magentaBoldUnderLine:Object = {color:0xD40073, bold:true, underline:true};
		
		var violet:Object = {color: 0x990066, bold:false, underline:false};
		var violetBold:Object = {color: 0x990066, bold:true, underline:false};
		var violetUnderLine:Object = {color:0x990066, bold:false, underline:true};
		var violetBoldUnderLine:Object = {color:0x990066, bold:true, underline:true};
		
		var black:Object = {color:0x666666, bold:false, underline:false};
		var blackBold:Object = {color:0x666666, bold:true, underline:false};
		var blackUnderLine:Object = {color:0x666666, bold:false, underline:true};
		var blackBoldUnderLine:Object = {color:0x666666, bold:true, underline:true};
		
		var white:Object = {color:0xFFFFFF, bold:false, underline:false};
		var whiteBold:Object = {color:0xFFFFFF, bold:true, underline:false};
		var whiteUnderLine:Object = {color:0xFFFFFF, bold:false, underline:true};
		var whiteBoldUnderLine:Object = {color:0xFFFFFF, bold:true, underline:true};
		
		var Disabled:Object = {color:0x666666, bold:false, underline:false};
		var UnderLineDisabled:Object  = {color:0x666666, bold:false, underline:true};
		var BoldUnderLineDisabled:Object  = {color:0x666666, bold:true, underline:true};

// STYLE OBJECT

/** style for Label class **/
		o = Style.newStyle("Label");
		
		o.marginTop = 0;
		o.marginBottom = 0;
		o.marginLeft = 0;
		o.marginRight = 0;
		
		o.paddingTop = 2;
		o.paddingBottom = 2;
		o.paddingLeft = 2;
		o.paddingRight = 2;
		
		o.setFormat("fu", white);
		
/** style for Description class **/
		o = Style.newStyle("Description");
		
		o.marginTop = 2;
		o.marginBottom = 2;
		o.marginLeft = 2;
		o.marginRight = 2;
		
		o.paddingTop = 2;
		o.paddingBottom = 2;
		o.paddingLeft = 2;
		o.paddingRight = 2;
		
		o.setFormat("fu", black);		
		
		
/** style for TextInput class **/
		o = Style.newStyle("TextBox");
		o.width = 150;
		o.height = 20;	
		
		o.marginTop = 2;
		o.marginBottom = 2;
		o.marginLeft = 2;
		o.marginRight = 2;
		
		o.paddingTop = 2;
		o.paddingBottom = 2;
		o.paddingLeft = 2;
		o.paddingRight = 2;
		
		o.setFormat("fu", Disabled);		

		o.borderBottomWidth = 1;
		o.borderBottomAlpha = 100;
		o.borderBottomColor = 0x990066;
		o.borderTopWidth = 1;
		o.borderTopAlpha = 100;
		o.borderTopColor = 0x990066;
		o.borderRightWidth = 1;
		o.borderRightAlpha = 100;
		o.borderRightColor = 0x990066;
		o.borderLeftWidth = 1;
		o.borderLeftAlpha = 100;
		o.borderLeftColor = 0x990066;
		
		o.backgroundAlpha = 100;
		o.backgroundColor = 0xFFFFFF;
		o.backgroundPosition = {x:0,y:0};
		
		o.cornerBottomRight = 0;
		o.cornerBottomLeft = 0;
		o.cornerTopRight = 0;
		o.cornerTopLeft = 0;
		
/** style for TextArea class **/
		o = Style.newStyle("TextArea");
		o.width = 410;
		o.height = 150;	
		
		o.marginTop = 2;
		o.marginBottom = 2;
		o.marginLeft = 2;
		o.marginRight = 2;
		
		o.paddingLeft = 3;
		o.paddingRight = 3;	
		o.paddingTop = 10;
		o.paddingBottom = 10;
		
		o.setFormat("fu", Disabled);
		
		o.borderBottomWidth = 1;
		o.borderBottomAlpha = 100;
		o.borderBottomColor = 0x990066;
		o.borderTopWidth = 1;
		o.borderTopAlpha = 100;
		o.borderTopColor = 0x990066;
		o.borderRightWidth = 1;
		o.borderRightAlpha = 100;
		o.borderRightColor = 0x990066;
		o.borderLeftWidth = 1;
		o.borderLeftAlpha = 100;
		o.borderLeftColor = 0x990066;		
		
		o.backgroundAlpha = 100;
		o.backgroundColor = 0xFFFFFF;
		o.backgroundPosition = {x:0,y:0};
		
		o.cornerBottomRight = 0;
		o.cornerBottomLeft = 0;
		o.cornerTopRight = 0;
		o.cornerTopLeft = 0;
		
/** style for Button class **/
		o = Style.newStyle("Button");
		
		o.marginTop = 2;
		o.marginBottom = 2;
		o.marginLeft = 2;
		o.marginRight = 2;
		
		o.paddingLeft = 5;
		o.paddingRight = 5;
		o.paddingBottom = 5;
		o.paddingTop = 5;
		
		o.setFormat("fu", white);
		
		o.backgroundAlpha = 100;
		o.backgroundColor = 0x990066;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 0;
		o.cornerBottomLeft = 0;
		o.cornerTopRight = 0;
		o.cornerTopLeft = 0;
		
		// over
		s = o.subStyle("over", true);
		s.setFormat("fu", whiteUnderLine);
		
		// press
		s = o.subStyle("press", true);
		s.setFormat("fu", whiteUnderLine);

		
/** style for CheckBox class **/
		o = Style.newStyle("CheckBox");
		o.width = 15;
		o.height = 15;
		
		o.marginTop = 2;
		o.marginBottom = 2;
		
		o.paddingLeft = 5;
		o.paddingRight = 5;
		
		o.setFormat("fu", black);
		
		// over
		s = o.subStyle("over", true);
		s.setFormat("fu", blackUnderLine);
		
		// press
		s = o.subStyle("press", true);
		s.setFormat("fu", blackUnderLine);
		
		// checkbox
		s = o.subStyle("checkbox");
		s.width = 14;
		s.height = 14;
		
		s.backgroundAlpha = 100;
		s.backgroundColor = 0x99CC33;
		s.backgroundPosition = {x:0,y:0};
		
		s.cornerBottomRight = 3;
		s.cornerBottomLeft = 3;
		s.cornerTopRight = 3;
		s.cornerTopLeft = 3;
		
		// checkbox select
		ss = s.subStyle("select");
		ss.width = 6;
		ss.height = 6;		
		ss.backgroundAlpha = 100;
		ss.backgroundColor = 0x000000;
		ss.backgroundPosition = {x:0,y:0};
		
		
/** style for RadioButton class **/
		o = Style.newStyle("RadioButton");
		o.width = 15;
		o.height = 15;
		
		o.marginTop = 2;
		o.marginBottom = 2;
		
		o.paddingLeft = 10;
		o.paddingRight = 10;
		
		o.setFormat("fu", black);

		// over
		s = o.subStyle("over", true);
		s.setFormat("fu", blackUnderLine);
		
		// press
		s = o.subStyle("press", true);
		s.setFormat("fu", blackUnderLine);
		
		// radiobullet
		s = o.subStyle("radiobullet");
		s.width = 12;
		s.height = 12;
		
		s.backgroundAlpha = 100;
		s.backgroundColor = 0x99CC33;
		s.backgroundPosition = {x:0,y:0};
		
			// radiobullet select
			ss = s.subStyle("select");
			ss.width = 6;
			ss.height = 6;
			
			ss.backgroundAlpha = 100;
			ss.backgroundColor = 0x000000;
			ss.backgroundPosition = {x:0,y:0};	
	
		
/** style for ScrollBar class **/
		o = Style.newStyle("ScrollBar");
		o.width = 10;
		o.height = 30;
		
		o.backgroundAlpha = 10;
		o.backgroundColor = 0xFFFFFF;
		o.backgroundPosition = {x:0,y:2};		

		s = o.subStyle("track", true);		
		s.backgroundAlpha = 100;
		s.backgroundColor = 0x666666;
		s.backgroundPosition = {x:0,y:2};	
		
			ss = s.subStyle("thumb", true);
			ss.width = 10;
			ss.height = 10;
			ss.backgroundColor = 0xCCCCCC;

		
		s = o.subStyle("min");
		s.width = 10;
		s.height = 10;
		s.backgroundAlpha = 100;
		s.backgroundColor = 0xF3F3F3;
		s.backgroundPosition = {x:0,y:2};

		
		s = o.subStyle("plus");
		s.width = 10;
		s.height = 10;
		s.backgroundAlpha = 100;
		s.backgroundColor = 0xF3F3F3;
		s.backgroundPosition = {x:0,y:0};
		
// STYLE CONTAINERS

/** style for Panel class **/
		o = Style.newStyle("Panel");
		
		o.marginTop = 10;
		o.marginBottom = 5;
		o.marginLeft = 10;
		o.marginRight = 10;
		
		o.paddingLeft = 10;
		o.paddingRight = 10;
		o.paddingBottom = 5;
		o.paddingTop = 10;
		
		o.backgroundAlpha = 100;
		o.backgroundColor = 0xD40073;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 0;
		o.cornerBottomLeft = 0;
		o.cornerTopRight = 0;
		o.cornerTopLeft = 0;	
		
		s = o.subStyle("header");
		s.height = 30;
		
		s.marginTop = 1;
		s.marginBottom = 1;
		s.marginLeft = 1;
		s.marginRight = 1;
		
		s.paddingLeft = 10;
		s.paddingRight = 10;
		s.paddingBottom = 10;
		s.paddingTop = 10;

		s.setFormat("fu",  {font:"kroeger", size:8, color: 0xffffff, bold:false, underline:false });
		
		s.backgroundAlpha = 100;
		s.backgroundColor = 0xD40073;
		s.backgroundPosition = {x:0,y:0};

		s.cornerBottomRight = 0;
		s.cornerBottomLeft = 0;
		s.cornerTopRight = 0;
		s.cornerTopLeft = 0;	
		
/** style for DeckBox class **/		
		o = Style.newStyle("DeckBox");		
		
		o.marginBottom = 5;
		o.marginLeft = 5;
		o.marginRight = 5;
		
		o.paddingLeft = 10;
		o.paddingRight = 10;
		o.paddingBottom = 10;
		o.paddingTop = 10;
		
		
/** style for TitleBox class **/
		o = Style.newStyle("TitleBox");
		
		o.marginTop = 5;
		o.marginBottom = 5;
		o.marginLeft = 5;
		o.marginRight = 5;
		
		o.paddingLeft = 10;
		o.paddingRight = 10;
		o.paddingBottom = 10;
		o.paddingTop = 10;
		
		o.backgroundAlpha = 100;
		o.backgroundColor = 0xF9F9F9;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 10;
		o.cornerBottomLeft = 10;
		o.cornerTopRight = 10;
		o.cornerTopLeft = 10;	
	
		o.borderBottomWidth = 2;
		o.borderBottomAlpha = 100;
		o.borderBottomColor = 0x999999;
		o.borderTopWidth = 2;
		o.borderTopAlpha = 100;
		o.borderTopColor = 0x999999;
		o.borderRightWidth = 2;
		o.borderRightAlpha = 100;
		o.borderRightColor = 0x999999;
		o.borderLeftWidth = 2;
		o.borderLeftAlpha = 100;
		o.borderLeftColor = 0x999999;	
		
		s = o.subStyle("label");
		s.width = 100;
		s.height = 20;
		
		s.paddingTop = 2;
		s.paddingBottom = 2;
		s.paddingLeft = 25;
		s.paddingRight = 10;
		
		s.setFormat("fu", black);
		
/** style for AccordionBox class **/
		o = Style.newStyle("AccordionBox");
		
		o.marginTop = 0;
		o.marginBottom = 0;
		o.marginLeft = 0;
		o.marginRight = 0;
		
		o.paddingLeft = 5;
		o.paddingRight = 5;
		o.paddingBottom = 5;
		o.paddingTop = 5;		

		o.backgroundAlpha = 100;
		o.backgroundColor = 0x000000;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 0;
		o.cornerBottomLeft = 0;
		o.cornerTopRight = 0;
		o.cornerTopLeft = 0;	
		
/** style for AccordionPanel class **/
		o = Style.newStyle("AccordionPanel");
		
		o.marginTop = 0;
		o.marginBottom = 0;
		o.marginLeft = 0;
		o.marginRight = 0;
		
		o.paddingLeft = 5;
		o.paddingRight = 5;
		o.paddingBottom = 2;
		o.paddingTop = 2;		

		o.backgroundAlpha = 100;
		o.backgroundColor = 0xFFFFFF;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 10;
		o.cornerBottomLeft = 10;
		o.cornerTopRight = 0;
		o.cornerTopLeft = 0;	
	
/** style for AccordionHeader class **/
		o = Style.newStyle("AccordionHeader");
		
		o.marginTop = 0;
		o.marginBottom = 0;
		o.marginLeft = 0;
		o.marginRight = 0;
		
		o.paddingLeft = 7;
		o.paddingRight = 7;
		o.paddingBottom = 2;
		o.paddingTop = 7;		
		
		o.setFormat("fu", greenBold);

		o.backgroundAlpha = 100;
		o.backgroundColor = 0x666666;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 0;
		o.cornerBottomLeft = 0;
		o.cornerTopRight = 0;
		o.cornerTopLeft = 0;	
		
		s = o.subStyle("select", true);
		s.setFormat("fu", Disabled);
		
		s.backgroundAlpha = 100;
		s.backgroundColor = 0xFFFFFF;
		s.backgroundPosition = {x:0,y:0};

		s.cornerBottomRight = 0;
		s.cornerBottomLeft = 0;
		s.cornerTopRight = 0;
		s.cornerTopLeft = 0;	
		
/** style for List class **/
		o = Style.newStyle("ListBox");
		
		o.marginTop = 0;
		o.marginBottom = 0;
		o.marginLeft = 0;
		o.marginRight = 0;
		
		o.paddingLeft = 5;
		o.paddingRight = 5;
		o.paddingBottom = 5;
		o.paddingTop = 5;		

		o.backgroundAlpha = 0;
		o.backgroundColor = 0xFFFFFF;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 0;
		o.cornerBottomLeft = 0;
		o.cornerTopRight = 0;
		o.cornerTopLeft = 0;	

		
		
/** style for ListItem **/
		o = Style.newStyle("ListItem");
		o.width = 250;
		o.height = 20;
		
		o.paddingLeft = 10;
		o.paddingRight = 10;
		
		o.setFormat("fu", white);		

		o.backgroundAlpha = 100;
		o.backgroundColor = 0xD40073;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 0;
		o.cornerBottomLeft = 0;
		o.cornerTopRight = 0;
		o.cornerTopLeft = 0;	
		
		// over
		s = o.subStyle("over", true);
		s.setFormat("fu", black);	
		
		s.backgroundAlpha = 100;
		s.backgroundColor = 0xffffff;
		s.backgroundPosition = {x:0, y:0};
		
		// press
		s = o.subStyle("press", true);
		s.setFormat("fu", black);
		
		s.backgroundAlpha = 100;
		s.backgroundColor = 0xFFFFFF;
		s.backgroundPosition = {x:0,y:0};	
		
		// selected
		s = o.subStyle("selected", true);
		s.setFormat("fu", black);
		
		s.backgroundAlpha = 100;
		s.backgroundColor = 0xFFFFFF;
		s.backgroundPosition = {x:0,y:0};	

		
		
/** style for TabPanel class **/
		o = Style.newStyle("TabPanels");
		o.marginBottom = 5;
		o.marginLeft = 5;
		o.marginRight = 5;
		
		o.paddingLeft = 10;
		o.paddingRight = 10;
		o.paddingBottom = 10;
		o.paddingTop = 10;
		
		o.backgroundAlpha = 100;
		o.backgroundColor = 0xFFFFFF;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 10;
		o.cornerBottomLeft = 10;
		o.cornerTopRight = 10;
		o.cornerTopLeft = 10;	
		
/** style for TabBox class **/
		o = Style.newStyle("TabBox");
		
/** style for Tab class **/		
		o = Style.newStyle("Tab");
		o.width = 10;
		o.height = 35;

		o.marginLeft = 5;
		
		o.paddingLeft = 7;
		o.paddingRight = 7;
		o.paddingTop = 10;
		
		o.setFormat("fu", green);
		
		o.backgroundAlpha = 100;
		o.backgroundColor = 0x000000;
		o.backgroundPosition = {x:0,y:5};
		
		o.cornerTopRight = 8;
		o.cornerTopLeft = 8;	
		
		s = o.subStyle("select", true);
		s.setFormat("fu", Disabled);
		s.backgroundColor = 0xFFFFFF;

		
/** style for Select class **/
		o = Style.newStyle("Select");
		o.width = 100;
		o.height = 25;
		
		o.marginTop = 2;
		o.marginBottom = 2;
		o.marginLeft = 2;
		o.marginRight = 2;
		
		o.paddingLeft = 10;
		o.paddingRight = 10;
		o.paddingBottom = 5;
		o.paddingTop = 5;
		
		o.setFormat("fu", white);
		
		o.backgroundAlpha = 100;
		o.backgroundColor = 0x99CC33;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 8;
		o.cornerBottomLeft = 8;
		o.cornerTopRight = 8;
		o.cornerTopLeft = 8;	

		// over
		s = o.subStyle("over", true);
		s.setFormat("fu", whiteUnderLine);
		
		// press
		s = o.subStyle("press", true);
		s.setFormat("fu", whiteUnderLine);
		
		
/** style for MenuBar class **/
		o = Style.newStyle("MenuBar");
		
/** style for MenuPopup class **/
		o = Style.newStyle("MenuPopup");
		o.width = 25;
		o.height = 25;
		
		o.paddingLeft = 10;
		o.paddingRight = 10;
		o.paddingBottom = 10;
		o.paddingTop = 10;
		
		o.backgroundAlpha = 100;
		o.backgroundColor = 0xF9F9F9;
		o.backgroundPosition = {x:0,y:0};

		o.cornerBottomRight = 2;
		o.cornerBottomLeft = 2;
		o.cornerTopRight = 2;
		o.cornerTopLeft = 2;	
		
		o.borderBottomWidth = 2;
		o.borderBottomAlpha = 100;
		o.borderBottomColor = 0x333333;
		o.borderTopWidth = 2;
		o.borderTopAlpha = 100;
		o.borderTopColor = 0x333333;
		o.borderRightWidth = 2;
		o.borderRightAlpha = 100;
		o.borderRightColor = 0x333333;
		o.borderLeftWidth = 2;
		o.borderLeftAlpha = 100;
		o.borderLeftColor = 0x333333;	
		
		
/** style for Menu class **/		
		o = Style.newStyle("Menu");
		
		o.marginLeft = 10;
		o.marginRight = 10;
		o.marginTop = 8;
		o.marginBottom = 5;
		
		o.paddingLeft = 2;
		o.paddingRight = 2;
		
		o.setFormat("fu", green);
				
		o.backgroundAlpha = 100;
		o.backgroundColor = 0xFFFFFF;
		
		s = o.subStyle("over", true);
		s.backgroundColor =  0x99CC33;
		s.setFormat("fu", whiteUnderLine);	
		
		s = o.subStyle("select", true);
		s.backgroundColor =  0x99CC33;
		s.setFormat("fu", whiteUnderLine);	
		
		// sub
		s = o.subStyle("sub", true);
		s.marginLeft = 0;
		s.marginRight = 0;
		s.marginTop = 0;
		s.marginBottom = 0;
		s.setFormat("fu", green);		
		s.icon = "arrow";

/** style for MenuItem class **/
		o = Style.newStyle("MenuItem");
		
		o.paddingLeft = 2;
		o.paddingRight = 2;

		o.setFormat("fu", black);
		
		// over
		s = o.subStyle("over", true);
		s.setFormat("fu", black);		
		s.borderBottomWidth = 2;
		s.borderBottomAlpha = 100;
		s.borderBottomColor = 0x99CC33;	
		
		// press
		s = o.subStyle("press", true);
		s.setFormat("fu", black);
		

		
	
/** style for HBox class **/
		o = Style.newStyle("HBox");
		
/** style for VBox class **/
		o = Style.newStyle("VBox");
		
/** style for Spacer class **/
		o = Style.newStyle("Spacer");
		
		
/** style for ToolTip **/
		o = Style.newStyle("ToolTip");
		o.width = 20;
		o.height = 20;
		
		o.marginTop = 4;
		o.marginBottom = 4;
		o.marginLeft = 4;
		o.marginRight = 4;
		
		o.paddingLeft = 2;
		o.paddingRight = 2;
		o.paddingBottom = 2;
		o.paddingTop = 2;
		
		o.setFormat("fu", {font:"Arial", size:10, color: 0x000000, bold:false, underline:false });
		
		o.backgroundAlpha = 100;
		o.backgroundColor = 0xF8F8CB;
		
		o.borderBottomWidth = 2;
		o.borderBottomAlpha = 100;
		o.borderBottomColor = 0x666666;
		o.borderTopWidth = 2;
		o.borderTopAlpha = 100;
		o.borderTopColor = 0x666666;
		o.borderRightWidth = 2;
		o.borderRightAlpha = 100;
		o.borderRightColor = 0x666666;
		o.borderLeftWidth = 2;
		o.borderLeftAlpha = 100;
		o.borderLeftColor = 0x666666;			
		
		
		s = o.subStyle("shadow");
	}
	
	private var _sID : String;
	private var embedFonts:Boolean;
	private var width, height:Number;
	private var backgroundAlpha:Number;
	private var backgroundImage:String;
	private var backgroundColor:Number;		
	private var backgroundPosition:Object;	
	private var marginLeft, marginRight, marginTop, marginBottom:Number;
	private var paddingLeft, paddingRight, paddingTop, paddingBottom:Number;
	private var cornerBottomRight, cornerBottomLeft, cornerTopRight, cornerTopLeft:Number;
	private var borderBottomWidth, borderTopWidth, borderRightWidth, borderLeftWidth:Number;
	private var borderBottomAlpha, borderTopAlpha, borderRightAlpha, borderLeftAlpha:Number;
	private var borderBottomColor, borderTopColor, borderRightColor, borderLeftColor:Number;		
	

	private var _styles:Object = {};	
	private var fu, fd, fo, df:Style;	
	private static var InheritableStyle:Object = { fu:1, fd:1, fo:1, df:1 };
}