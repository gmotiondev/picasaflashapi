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
class be.netdust.visual.object.ListItem
extends be.netdust.visual.containers.Node
{
	public var styleClass:String = "ListItem";
	
	public function ListItem( _label:String, _value:Object, _styleID ) {
		super( _styleID );
		setLabel( _label );
		setValue( _value );	
	};
	
	public function setLabel( val:String ) 
	{
		label = val;
		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";	
	};
	
	public function getLabel() : String
	{
		return label!=null?label:"";
	};
	
	public function doLayout() 
	{
		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";	
		_bttnalign();
	}
	
	private function setup() {
		super.setup();
		
		if( ui.label!=undefined ) _labeltf = ui.label
		else {
			ui.createTextField( "label", 1 , getStyle().paddingLeft, getStyle().paddingTop, width - getStyle().paddingLeft, height - getStyle().paddingBottom );	
			_labeltf = ui.label;
			_labeltf.setNewTextFormat( getStyle().getFormat("fu") );
			_labeltf.embedFonts = getStyle().embedFonts;
			_labeltf.selectable = false;	
			_labeltf.multiline = false;
			_labeltf.wordWrap = false;				
		};
	}
	
	private function _bttnalign()
	{
		var h:Number = _labeltf._height + getStyle().vpadding + getStyle().vborder;		
		
		if( height < h ) height = h;
		else _labeltf._y = height/2 -  _labeltf._height/2;		
	}

	private var _labeltf:TextField = null
	
	
}