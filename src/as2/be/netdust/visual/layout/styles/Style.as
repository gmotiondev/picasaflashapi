import com.bourre.log.PixlibStringifier;

import be.netdust.visual.layout.styles.bordertheme.Theme;
class be.netdust.visual.layout.styles.Style
{
	public var skin:String;	
	
	public var icon:String;
	public var embedFonts:Boolean;
	public var horizontal:String;
	public var borderStyle:String;
	public var width, height:Number;
	public var minwidth, minheight:Number;
	public var maxwidth, maxheight:Number;
	public var backgroundAlpha:Number;
	public var backgroundImage:String;
	public var backgroundColor:Number;		
	public var backgroundPosition:Object;	
	public var marginLeft, marginRight, marginTop, marginBottom:Number;
	public var paddingLeft, paddingRight, paddingTop, paddingBottom:Number;
	public var cornerBottomRight, cornerBottomLeft, cornerTopRight, cornerTopLeft:Number;
	public var borderBottomWidth, borderTopWidth, borderRightWidth, borderLeftWidth:Number;
	public var borderBottomAlpha, borderTopAlpha, borderRightAlpha, borderLeftAlpha:Number;
	public var borderBottomColor, borderTopColor, borderRightColor, borderLeftColor:Number;	
	
	public function get vpadding( ) : Number {
		return paddingTop + paddingBottom; 
	};
	public function get hpadding( ) : Number {
		return paddingRight + paddingLeft;
	};
	public function get vmargin( ) : Number {
		return marginTop + marginBottom;
	};
	public function get hmargin( ) : Number {
		return marginRight + marginLeft;
	};	
	public function get vborder( ) : Number {
		return borderBottomWidth + borderTopWidth;
	};
	public function get hborder( ) : Number {
		return borderRightWidth + borderLeftWidth;
	};

	/** 
	* contstructor: create a style with textformat properties
	* @param	tf a object containing the new textformat properties.
	* 
	*/
	public function Style( tf:Object ) 
	{
		_formats = {};
		_substyles = {};
		if( tf != undefined ) {
			styleTextFormat = new TextFormat();
			for (var i:String in tf) styleTextFormat[i] = tf[i];
		};
	}
	

	/** 
	* sets the textFormat properties of a style.
	* 
	* @param	formatName	a string indicating the name of the child style to be created.
	* @param	s			an object containing the textformat style properties to add to the child style.
	*/
	public function setFormat(formatName:String, formatObject:Object) 
	{
		_formats[formatName] = inheritFormat( formatName, new Style( formatObject ) );
	};
	
	/** 
	* gets the textFormat properties of a style.
	* 
	* @param	formatName	a string indicating the name of the child style to be created.
	*/
	public function getFormat(formatName:String) : TextFormat 
	{
		return _formats[formatName];
	};
	
	/** 
	* passes any existing inheritable textformat properties from the theme style to a child style.
	* 
	* @param	formatName	a string indicating the name of the newly created child style.
	* @param	s			a style object containing the textformat style to add to the child's style properties inherited from the theme.
	* @return 				the modified child style.
	*/
	public function inheritFormat(formatName:String, s:Style) : TextFormat 
	{
		for(var i:String in InheritableTextFormat) {
			if (s.styleTextFormat[i] == null) {				
				s.styleTextFormat[i] = _theme[formatName].styleTextFormat[i];
			}
		}
		return s.styleTextFormat;
	};
	
	/** 
	* creates a style that is the child of the current style.
	* 
	* @param	className	a string indicating the name of the child style to be created.
	* @param	inherit		boolean indecating inheritance from parent or theme
	* @return 				the newly created child style.
	*/
	public function subStyle( className:String, _inherit:Boolean ) : Style 
	{
		if( !_inherit ) _substyles[className] = _theme.inheritStyle( new Style( ) );
		else _substyles[className] = this.inheritStyle( new Style( ) );
		
		_substyles[className]._sParent = this._sID;
		_substyles[className]._sID = className;
		
		return _substyles[className];		
	};
	
	/** 
	* gets a style that is the child of the current style.
	* 
	* @param	formatName	a string indicating the name of the child style to be created.
	*/
	public function getSubStyle( className:String ) : Style
	{
		return _substyles[className];
	}
	
	/** 
	* passes any existing inheritable style properties to another style object.
	* 
	* @param	s	the style to receive the inherited style properties.
	* @return		the style after having received the inherited style properties.
	*/
	public function inheritStyle( s:Style ) : Style {
		for(var i:String in this) {
			if ( i != "_substyles" ) 
			{	
				if( i == "_formats" ) {
					s[i] = {};
					for(var p:String in this[i] ) s[i][p] = Style.cloneTextFormat(this[i][p]);
					
				}
				else
				if( s[i] instanceof Object ) {
					s[i] = {};
					for(var p:String in this[i] ) s[i][p] = this[i][p];
				}
				else
				s[i] = this[i];
			}
		};
		return s;
	};

	public function getID() : String 
	{
		return _sID;
	};
	
	public function toString() : String 
	{
		return PixlibStringifier.stringify( this ) +" id: " + _sID ;
	};
	
	/*
	 * static methods
	 */

	/** 
	* return a style that is a child of the theme.
	* 
	* @param	className	a string indicating the name of the child style.
	* @return 				the child style.
	*/
	public static function getStyle( className:String ) : Style 
	{
		return _theme.getStyle( className );
	}
	
	/** 
	* creates a new style that is a child of the theme.
	* 
	* @param	className	a string indicating the name of the child style to be created.
	* @return 				the newly created child style.
	*/
	public static function newStyle( className:String ) : Style 
	{	
		var _oStyle:Style = _theme.inheritStyle( new Style( ) );
		_theme.registerStyle( className, _oStyle );
		_oStyle._sID = className;

		return _oStyle; 		
	};
	
	/** 
	* creates a new style that has identical properties and structure to the style given.
	* 
	* @param	s	a string indicating the name of the style to be cloned.
	* @return 		the newly cloned style.
	* 
	*/
	public static function cloneStyle( _s:Style ) : Style 
	{
		var clone:Style = new Style();
	
		for (var i:String in _s ) {				

				if( i == "_formats" ) {
					clone[i] = {}
					for( var p:String in _s[i] ) clone[i][p] = Style.cloneTextFormat( _s[i][p] );
				}

				if( i == "_substyles" ) {
					clone[i] = {}
					for( var p:String in _s[i] ) clone[i][p] = Style.cloneStyle( _s[i][p] );
				}
				
				else clone[i] = _s[i];
		}

		return clone;
	};
	
	public static function cloneTextFormat( _tf:TextFormat ) : TextFormat
	{
		var _txtf : TextFormat = new TextFormat();
		for( var p:String in _tf ) _txtf[p] = _tf[p];
		return _txtf;
	}
	
	public static function isRegistered( themeName:String ) : Boolean 
	{
		return ( Style._themes[ themeName] != undefined );
	};

	public static function registerTheme( themeName:String, theme:Theme ) : Boolean 
	{
		if ( Style.isRegistered( themeName ) ) {
			trace( "Style instance is already registered with '" + themeName + "' name." );
			return false;
		} else {
			Style._themes[ themeName ] = theme;			
			_theme = theme;
			return true;
		}
	};
	
	public static function unregister( themeName:String ) : Void  
	{
		// mg
		Style._themes[themeName] = null;
	};
	
	private var _sID : String;
	private var _formats : Object;
	private var _substyles : Object;
	private var styleTextFormat:TextFormat;
	
	private static var _theme : Theme;
	private static var _themes : Object = new Object();
		
	private static var InheritableStyle:Object = {fu:1, fd:1, fo:1, df:1};
	private static var InheritableTextFormat:Object = {font:1, size:1, color:1, bold:1, italic:1, underline:1, shadow:1};
}