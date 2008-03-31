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
import com.bourre.events.IEvent;

import be.netdust.visual.UIContainer;
import be.netdust.visual.events.BubbleEvent;
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.managers.FocusManager;
import be.netdust.visual.managers.IFocus;
class be.netdust.visual.containers.Panel extends UIContainer implements be.netdust.visual.managers.ITabGroup
{
	public var styleClass:String = "Panel";
	private var header:MovieClip;
	
	/*
	* Constructor.
	*/
	public function Panel( _label:String, _styleID )
	{
		super( _styleID );	
		setLabel( _label );
	}
	
	public function getFocusManager() : FocusManager
	{
		return _ofocusManager;
	};
	
	public function onFocus( e:IEvent ) : Void
	{
		if( BubbleEvent(e).getHandle()  == BubbleEvent.REGISTERFOCUS  )
		getFocusManager().registerElement( IFocus( BubbleEvent(e).getSource() ) )
		else {
			getFocusManager().elementRecievedfocus( IFocus( BubbleEvent(e).getSource() ) )
		}
	};
	
	public function setFocus( _oCurr:IFocus, _oNext:IFocus ) : Void 
	{

	};
	
	public function paint() 
	{
		createChild();
		doLayout();
		
		_skin.draw( header, w - _headerstyle.hmargin, _headerstyle.height, _headerstyle );
		_skin.draw( ui, w, h , getStyle() );		
	}

	
	/**
	* @method      Panel.doLayout()
	* @description Public method for placing elements of container.
	* @usage       <code>Panel.doLayout():Void;</code> 
	*/
	public function doLayout():Void 
	{
		super.doLayout();	
		doSize();
		
		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";
		
		_labeltf._x = _headerstyle.paddingLeft;
		_labeltf._y = _headerstyle.paddingTop;		
		header._x = _headerstyle.marginLeft;
		header._y = _headerstyle.marginTop;
		
		childs_mc._y += ( _headerstyle.height?_headerstyle.height:0 );
		
	}
	
	/**
	* @method      Panel.doSize()
	* @description Calculates containers width and height from content.
	* @usage       <code>Panel.doSize():Void;</code> 
	*/
	public function doSize() : Void
	{
		w = width;
		h = height;
		h += (_headerstyle.height?_headerstyle.height:0);		
	}
	
	/**
	* @method      Panel.setup
	* @description setup of Panel.
	* @usage       <code>Panel.setup():Object;</code> 
	*/
	private function setup():Void 
	{
		super.setup();			
		if( ui.label!=undefined ) _labeltf = ui.label
		else {
			header = ui.createEmptyMovieClip( "header", 1 , 0, 0, _headerstyle.width, _headerstyle.height );	
			header.createTextField( "label", 1 , 0, 0, _headerstyle.width, _headerstyle.height );	
			_labeltf = header.label;
			_labeltf.setNewTextFormat( _headerstyle.getFormat("fu") );
			_labeltf.embedFonts = getStyle().embedFonts;
		};	
		
		_ofocusManager = FocusManager.getInstance( getReference(), this );
	};
	
	/**
	* @method      Panel.init
	* @description Initialization of Panel.
	* @usage       <code>Panel.init():Void;</code> 
	*/
	private function init():Void
	{
		super.init();		
		
		//_ofocusManager = new FocusManager( this );
		layoutmanager.setDirection( "vertical" );
		_headerstyle = getStyle().getSubStyle("header");
	}
	
	private var w:Number;
	private var h:Number;
	private var _labeltf:TextField;
	private var _headerstyle:Style;
	private var _ofocusManager:FocusManager;

}