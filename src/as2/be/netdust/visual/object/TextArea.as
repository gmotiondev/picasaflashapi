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
import be.netdust.visual.object.ScrollBar;
import be.netdust.visual.object.Label;

class be.netdust.visual.object.TextArea extends Label
{
	
	public var styleClass:String = "TextArea";
	
	// SCROLL IMPLEMENTATION 
	
	public function set scroll( n:Number ) {
		_labeltf.scroll = n;
		
	}
	public function get scroll(  ) :Number {
		return _labeltf.scroll;
	}
	
	public function set bottomScroll( n : Number  ) {
		_labeltf.bottomScroll = n;
	}
	
	public function get bottomScroll() : Number {
		return _labeltf.bottomScroll;
	}
	
	public function set maxscroll( n:Number ) {
		_labeltf.maxscroll = n
	}
	public function get maxscroll(  ):Number {
		return _labeltf.maxscroll;
	}
	
	public function TextArea( _sValue:String , _styleID ) {
		super( _sValue, _styleID );
	};	
	
	public function paint()
	{
		super.paint();
		_scrollbar.paint();
		
	}

	public function doLayout() 
	{		
		_labeltf.text = getLabel();
		
		_labeltf.type = "input";
		_labeltf.wordWrap  = true;
		_labeltf.multiline = true;
		
		_labeltf.onChanged = Delegate( this, _ontextChange );
		_labeltf._width =  width - _scrollbar.width - getStyle().borderLeftWidth;		
		
		_scrollbar.setPosition( width - _scrollbar.width - getStyle().borderLeftWidth, getStyle().borderTopWidth );
	};
	
	
	private function setup()
	{
		super.setup();
		_labeltf.type = "input";
		_labeltf.selectable = true;
		
		_createScrollBar();
	}
	
	private function _ontextChange()
	{
		_scrollbar.update()
	}
	
	private function _createScrollBar() 
	{
		var scrollmc:MovieClip = ui.createEmptyMovieClip( "scroller", 999 );			
		_scrollbar = ScrollBar.createInstance( "ScrollBar" );
		
		var scrollstyle = _scrollbar.getStyle();
		scrollstyle.cornerTopRight = getStyle().cornerTopRight;
		scrollstyle.cornerBottomRight = getStyle().cornerBottomRight;
		
		var bttn_up = scrollstyle.getSubStyle("min");
		bttn_up.cornerTopRight = getStyle().cornerTopRight;
		
		var bttn_down = scrollstyle.getSubStyle("plus");
		bttn_down.cornerBottomRight = getStyle().cornerBottomRight;

		_scrollbar.setParent( this );
		_scrollbar.scrollTarget = this;
		_scrollbar.setContainer( scrollmc );
	};
	
	private var _focusInstance:Boolean = true;
	private var _scrollbar:ScrollBar;
	
}