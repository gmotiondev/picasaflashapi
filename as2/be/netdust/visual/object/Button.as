/** * Copyright (c) 2007 Stefan Vandermeulen - netdust.be 
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import be.netdust.visual.object.Label;
class be.netdust.visual.object.Button extends Label
{
	public var styleClass:String = "Button";	
	
	
	public function Button( _sValue:String, _styleID ) 
	{
		super( _sValue, _styleID );
	}
	
	public function setImage( _icon:String )
	{
		_sIconID = _icon;
	}
	
	public function doLayout() 
	{
		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";	
		
		_bttnalign();
		
		if( _sIconID!= undefined )
		{
			icon.attachMovie( _sIconID, "icon", 1 );
			icon._visible = true;

			switch( _sorient )
			{
				case "vertical":
					if( _sdirection !="reverse" ) _vertical();
					else  _vertReverse();
					
					width = (icon._width > _labeltf._width ) ? icon._width + getStyle().hpadding : width;
					height = (icon._height + getStyle().paddingTop ) + _labeltf._height + getStyle().vpadding + getStyle().vborder;
				break;
				default: 
					if( _sdirection !="reverse" ) _horizontal();
					else _horReverse();
					
					width = (icon._width +getStyle().paddingLeft )+ _labeltf._width + getStyle().hpadding;
					height = height < (icon._height + getStyle().vpadding + getStyle().vborder ) ? (icon._height + getStyle().vpadding + getStyle().vborder ) : height;
				break;
			};
		}
	}
	
	private function onKeyUp()
	{
		_onStateHandler( "press" );		
	}
	
	private function _bttnalign()
	{
		var w:Number = _labeltf._width + getStyle().hpadding + getStyle().hborder;
		var h:Number = _labeltf._height + getStyle().vpadding + getStyle().vborder;		
		
		if( width < w ) width = w;
		else _labeltf._x = width/2 -  _labeltf._width/2;
		if( height < h ) height = h;
		else _labeltf._y = height/2 -  _labeltf._height/2;		
	}

	private function _vertReverse()
	{
		_labeltf._x = width/2 - _labeltf._width/2;
		_labeltf._y = getStyle().paddingTop;
		icon._x = width/2 - icon._width/2;
		icon._y = _labeltf._height + getStyle().paddingTop*2;			
	}
	
	private function _vertical()
	{
		icon._x = width/2 - icon._width/2;
		icon._y = getStyle().paddingTop;					
		_labeltf._x = width/2 - _labeltf._width/2;
		_labeltf._y = icon._height + getStyle().paddingTop*2;			
	}
	
	private function _horReverse()
	{
		_labeltf._x = getStyle().paddingLeft;
		_labeltf._y = getStyle().paddingTop;
		icon._x = _labeltf._width + getStyle().paddingLeft*2;
		icon._y = height/2 - icon._height/2;			
	}
	
	private function _horizontal()
	{
		icon._x = getStyle().paddingLeft;
		icon._y = height/2 - icon._height/2;					
		_labeltf._x = icon._width + getStyle().paddingLeft*2;
		_labeltf._y = getStyle().paddingTop;			
	}
	
	private function _onStateHandler( _state:String ) 
	{		
		_skin.setState( ui, _state, getStyle() );

		switch( _state )
		{
			case "release": 
				callObserver("onCommand"); 
				dispatchEvent( ON_CLICK_EVENT );
			break;
			case "press": callObserver("onFocus"); break;
			case "over": break;
			case "out": break;			
		}
	}
	
	private function setup() 
	{
		super.setup();

		if( ui.icon!=undefined ) icon = ui.icon
		else {
			icon = ui.createEmptyMovieClip( "icon", 2 );
			icon._visible = false;
		}
		
		ui.onPress = Delegate( this, _onStateHandler, "press" );
		ui.onRollOut = Delegate( this, _onStateHandler, "out" );
		ui.onRollOver = Delegate( this, _onStateHandler, "over" );
		ui.onRelease = Delegate( this, _onStateHandler, "release" );
		ui.onDragOutside = Delegate( this, _onStateHandler, "releaseout" );
		ui.onReleaseOutside = Delegate( this, _onStateHandler, "releaseout" );
	}
	
	private var _focusInstance:Boolean = true;
	private var _sIconID:String = null;
	private var icon:MovieClip = null;
	
}