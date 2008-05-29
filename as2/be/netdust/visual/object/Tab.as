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
import be.netdust.visual.object.Button;
class be.netdust.visual.object.Tab
extends Button
{
	private var _select:Boolean= false;
	
	public var styleClass:String = "Tab";
	public var panelReference:String = null;
	
	public function set selected( _bSel:Boolean )
	{
		_select= _bSel;	
		if( selected ) _onStateHandler( "select" );
		else _onStateHandler( "deselect" );
	};
	
	public function get selected( ):Boolean 
	{
		return _select; 
	};
	
	public function Tab( _sValue:String, _styleID ) 
	{
		super( _sValue, _styleID );		
	};
	
	public function doLayout() 
	{
		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";	
		_labeltf.selectable = false;
		
		_labeltf._x = Math.round(getStyle().paddingLeft);
		_labeltf._y = Math.round(getStyle().paddingTop);
		
		width = _labeltf._width + Math.round(getStyle().hpadding);
		
		if( selected ) _onStateHandler( "select" );
	};
	
	private function init()
	{
		super.init();
		selected = false;
	}
	
	private function _onStateHandler( _state:String )
	{
		if( _state == "press"  ) {
			selected =  true;
		}
		else
		if( _state =="select" ) {
			callObserver( "onClick" );
			_skin.setState( ui, "select", getStyle() );
		}
		else {
			_skin.setState( ui, selected?"select":_state, getStyle() );
		};		
	};
	
	private var _focusInstance:Boolean = false;
}