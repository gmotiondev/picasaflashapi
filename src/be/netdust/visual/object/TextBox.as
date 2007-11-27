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

class be.netdust.visual.object.TextBox extends Label
{
	public var styleClass:String = "TextBox";
	
	public function set dataprovider( d ) {
		_dataprovider = d.getData();
	};
	
	public function get dataprovider( ) : Array {
		return _dataprovider;
	};
	
	public function set maxlength( n:Number ) {
		_maxlength = n;
	};
	
	public function get maxlength( ) : Number {
		return _maxlength;
	};
	
	public function set multiline( b:Boolean ) {
		_multiline = b;
	};
	
	public function get multiline( ) : Boolean {
		return _multiline;
	};
	
	public function getTextField():TextField
	{
		return _labeltf;
	};
	
	public function setType( t:String )
	{
		_type = t;
	};
	
	public function getType(  ) : String
	{
		return _type;
	};
	
	public function TextBox( _sValue:String, _styleID ) {
		super( _sValue, _styleID );	
	};
	
	public function doLayout() {	
		
		_labeltf.text = getLabel();		
		_labeltf.type = "input";
		
		_labeltf.restrict = _type=="numbers" ? "0-9" : null;
		_labeltf.password = _type=="password" ? true : false;	
		_labeltf.multiline = multiline;
		_labeltf.maxChars = maxlength;
	};
	
	private function setup()
	{
		super.setup()
		
		_labeltf.type = "input";
		_labeltf.selectable = true;
		
		if( _type == "autocomplete" ){
			_enabled = true;
			Key.addListener( this );
			_labeltf.onChanged = Delegate( this, _checkForValue );
		}
		_labeltf.onChanged = Delegate( this, callObserver, "onChanged" );
		_labeltf.onSetFocus = Delegate( this, callObserver, "onFocus" );
	};
	
	private function onKeyDown () : Void 
	{
		if (Key.isDown(Key.BACKSPACE)) {
			_enabled = false;
		} else _enabled = true;
	};
	
	private function _checkForValue( )
	{
		var _stValue:String = _labeltf.text;
		var l:Number = _dataprovider.length;
		var h:Array = [];
		
		if( _stValue.length >= 1 && _enabled )
		{
			while( l ){
				if( _stValue == _dataprovider[--l].label.substr(0, _stValue.length ) )
				h.push( _dataprovider[l].label );
			}
			
			if( h.length >= 1 )
			_labeltf.text = h[0];
			Selection.setSelection( _stValue.length, _labeltf.text.length );
		}		
	};
	
	private var _type:String;
	private var _dataprovider:Array;
	private var _enabled:Boolean=false;	
	private var _maxlength:Number = null;
	private var _multiline:Boolean = false;
	private var _focusInstance:Boolean = true;
	
	
}