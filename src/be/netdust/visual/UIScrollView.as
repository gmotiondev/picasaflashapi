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
import be.netdust.visual.UIContainer;
import be.netdust.visual.object.ScrollBar;

class be.netdust.visual.UIScrollView 
extends UIContainer
{
	public var styleClass:String = "UIScrollView";
	
	/**
	* @method      UIViewStack.scroll
	* @description Sets topmost line of content in UIViewStack
	* @usage       <code>UIViewStack.scroll:Number;</code> 
	*
	*/
	public function set scroll( n:Number )
	{
		bottomScroll = ( bottomScroll<rows ) ? bottomScroll+(__scroll>Math.floor(n)?1:-1) : (rows + ( scroll-1 ) );
		__scroll = Math.floor(n);
		doScroll();
	};
	
	/**
	* @method      UIViewStack.scroll
	* @description Gets topmost line of content in UIViewStack
	* @usage       <code>UIViewStack.scroll:Number;</code> 
	*
	*/
	public function get scroll(  ) :Number 
	{
		return __scroll;
	};
	
	/**
	* @method      UIViewStack.bottomScroll
	* @description Sets bottommost line that is currently visible in UIViewStack
	* @usage       <code>UIViewStack.bottomScroll:Number;</code> 
	*
	*/
	public function set bottomScroll( n : Number  ) 
	{
		__bottomScroll = n;
	};
	
	/**
	* @method      UIViewStack.bottomScroll
	* @description Gets bottommost line that is currently visible in UIViewStack
	* @usage       <code>UIViewStack.bottomScroll:Number;</code> 
	*
	*/
	public function get bottomScroll() : Number 
	{
		return __bottomScroll;
	};
	
	/**
	* @method      UIViewStack.maxscroll
	* @description Sets the maximum value of UIViewStack.scroll
	* @usage       <code>UIViewStack.maxscroll:Number;</code> 
	*
	*/
	public function set maxscroll( n:Number ) 
	{
		__maxscroll = n
	};
	
	/**
	* @method      UIViewStack.maxscroll
	* @description Gets the maximum value of UIViewStack.scroll
	* @usage       <code>UIViewStack.maxscroll:Number;</code> 
	*
	*/
	public function get maxscroll(  ):Number 
	{
		return __maxscroll;
	};
	
	/**
	* @method      UIViewStack.rows
	* @description Sets the value of UIViewStack.rows
	* @usage       <code>UIViewStack.rows:Number;</code> 
	*
	*/
	public function set rows( n:Number ) 
	{
		_maxrows = n
	};
	
	/**
	* @method      UIViewStack.rows
	* @description Gets the value of UIViewStack.rows
	* @usage       <code>UIViewStack.rows:Number;</code> 
	*
	*/
	public function get rows(  ):Number 
	{
		return _maxrows;
	};
	
	/**
	* Constructor
	*/
	public function UIScrollView( _styleID )
	{
		super( _styleID );		
	};
	
	/**
	* @method      UIScrollView.getContentWidth
	* @description Gets width of UIScrollView contentbox.
	* @usage       <code>UIScrollView.getContentWidth:Number;</code> 
	*
	* @return	Number; width of UIScrollView contentbox, in pixels.
	*/
	public function getContentWidth(  ) : Number
	{
		return width - ( getStyle().hpadding + getStyle().hborder ); 
	};
	
	/**
	* @method      UIScrollView.getContentHeight
	* @description Gets height of UIScrollView contentbox.
	* @usage       <code>UIScrollView.getContentHeight:Number;</code> 
	*
	* @return	Number; height of UIScrollView contentbox, in pixels.
	*/
	public function getContentHeight(  ) : Number
	{
		if( _maxrows != 0 ) return _maxrows * ( getChild(0).height + getChild(0).getStyle().vmargin  );
		else return height - ( getStyle().vpadding + getStyle().vborder );
	};
	
	/**
	* @method      UIScrollView.doLayout
	* @description layout for UIScrollView
	* @usage       <code>UIScrollView.doLayout():Void;</code> 
	*/
	public function doLayout() : Void
	{
		height = getContentHeight( );
		doMask();
		onOverflow();		
		_scrollbar.setPosition( width - _scrollbar.width - getStyle().borderLeftWidth, getStyle().borderTopWidth );
	}
	
	public function clear()
	{
		_scrollbar.clear();
		_scrollbar=null;
		super.clear();
	}
	
	/**
	* @method      UIScrollView.doScroll
	* @description scroll items in UIScrollView.
	* @usage       <code>UIScrollView.doScroll():Void;</code> 
	*/
	private function doScroll() : Void
	{
		childs_mc._y = -( ( getChild(0).height + getChild(0).getStyle().vmargin  ) * ( scroll-1 ) );
	};
	
	/**
	* @method      UIScrollView.onOverflow()
	* @description checks overflow
	* @usage       <code>UIScrollView.onOverflow():Void;</code> 
	*/	
	private function onOverflow( ) : Void
	{
		if( childs.length > _maxrows && _maxrows != 0 )
		{
			if( _scrollbar == null ) _createScrollBar();
			_scrollbar.create();
		}
	}
	
	
	
	/**
	* @method      UIScrollView.setup()
	* @description setup
	* @usage       <code>UIScrollView.setup():Void;</code> 
	*/	
	private function setup() : Void
	{
		super.setup();

		bottomScroll = ( childs.length-1<rows) ? childs.length-1 : ( Number(rows) + ( scroll-1 ) );
		maxscroll = ( childs.length - bottomScroll ) + 1 > 0 ? ( childs.length - bottomScroll ) + 1 : 1;
	}
	
	/**
	* @method      UIScrollView.onOverflow()
	* @description recieves overflow event
	* @usage       <code>UIScrollView.onOverflow():Void;</code> 
	*/
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

	private var _scrollbar:ScrollBar = null;	
	
	private var _maxrows:Number = 0;			
	private var __scroll:Number = 1;
	private var __maxscroll:Number = 1;
	private var __bottomScroll:Number = 0;
}