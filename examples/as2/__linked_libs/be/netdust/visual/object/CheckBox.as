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
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.object.Button;
class be.netdust.visual.object.CheckBox
extends Button
{
	public var styleClass:String = "CheckBox";
	public var isSelected:Boolean;
	
	public function CheckBox( _sValue:String, _styleID ) {
		super( _sValue, _styleID );		
	}
	
	public function setChecked( b:Boolean )
	{
		isSelected = b;
		if( ui ) doLayout();
	}
	
	public function paint() {
		super.paint();		
		
		_skin.draw( checkbox, checkerstyle.width, checkerstyle.height, checkerstyle );	
		_skin.draw( checkbox.select, checkerselectstyle.width, checkerselectstyle.height, checkerselectstyle );	
		
		_skin.draw( ui, width, height, getStyle() );		
	}
	
	public function doLayout() {
		
		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";	
		_labeltf.selectable = false;	

		checkbox._x = getStyle().paddingLeft;
		checkbox._y = height/2 - checkerstyle.height/2;
		
		_labeltf._x = checkerstyle.width + getStyle().paddingLeft*2;
		_labeltf._y = getStyle().paddingTop;
		
		width = _labeltf._x + _labeltf._width + getStyle().paddingRight;
		height =  getStyle().paddingTop + _labeltf._height + getStyle().paddingBottom;
		
		if( isSelected ) checkbox.select._visible = true;
		else checkbox.select._visible = false;
		
		checkbox.select._x = checkerstyle.width/2 - checkerselectstyle.width/2;
		checkbox.select._y = checkerstyle.height/2 - checkerselectstyle.height/2;
	}
	

	private function _onStateHandler( _state:String ) {		
		if( _state=="press" ) {
			setChecked( !isSelected );
		};
		
		super._onStateHandler( _state );
	}
	
	private function setup()
	{
		super.setup();
		
		if( ui.checkbox != undefined ) checkbox = ui.checkbox
		else
		{
			checkbox = ui.createEmptyMovieClip( "checkbox", 2 );
			var select:MovieClip = checkbox.createEmptyMovieClip( "select", 1 );
			select._visible = false;
		}
	}
	
	private function init() {
		super.init()
		
		checkerstyle = getStyle().getSubStyle("checkbox");
		checkerselectstyle = checkerstyle.getSubStyle("select")
		isSelected = false
	}
	
	private var checkerselectstyle:Style = null;
	private var checkerstyle:Style = null;
	private var checkbox:MovieClip = null;
}