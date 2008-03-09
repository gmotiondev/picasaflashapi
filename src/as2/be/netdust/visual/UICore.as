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
import com.bourre.log.PixlibStringifier;

import be.netdust.visual.assembler.expert.ComponentExpert;
import be.netdust.visual.layout.styles.bordertheme.Theme;
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.layout.skins.*;
import be.netdust.visual.managers.IKey;

class be.netdust.visual.UICore extends be.netdust.visual.events.EventDispatcher implements IKey
{
	/*
	* create default skin styles
	*/
	public static var UISKIN : ISkin;
	public static var initStyleInstance:Theme;	
	/**/
	
	public var ui:MovieClip = null;
	public var label:String = null;	
	public var container:MovieClip = null;		
	public var styleClass:String = "Core";

	
	/**
	* @method      UICore.createInstance
	* @description Factory method for a UICore instance
	* @usage       <code>UICore.createInstance(_sPackage:String, oArgs:Object);</code> 
	*/
	public static function createInstance( _sPackage:String, oArgs:Object ) 
	{
		return ComponentExpert.createInstance( _sPackage, oArgs.id, oArgs.style, oArgs.label );
	};
	
	/**
	* @method      UICore.onKeyDown()
	* @description Implementation of IKey
	* @usage       overwrite <code>UICore.onKeyDown():Void;</code> 
	*/	
	public function onKeyDown() : Void
	{
		//
	};	
	/**
	* @method      UICore.onKeyUp()
	* @description Implementation of IKey
	* @usage       overwrite <code>UICore.onKeyUp():Void;</code> 
	*/		
	public function onKeyUp() : Void
	{
		//
	};

	
	/**
	* @method      UICore.width
	* @description Sets width of ui, in pixels.
	* @usage       <code>UICore.width:Number;</code> 
	*
	* @return	Number; width of ui, in pixels.
	*/
	public function set width( w:Number )
	{
		getUI()._width = w; 
	};
	
	/**
	* @method      UIObject.width
	* @description Returns width of ui, in pixels.
	* @usage       <code>UIObject.width:Number;</code> 
	*
	* @return	Number; width of ui, in pixels.
	*/
	public function get width() : Number
	{
		return getUI()._width;
	};
	
	/**
	* @method      UICore.height
	* @description Sets height of ui, in pixels.
	* @usage       <code>UICore.height:Number;</code> 
	*
	* @return	Number; height of ui, in pixels.
	*/
	public function set height( h:Number)
	{
		getUI()._height = h
	};	
	
	/**
	* @method      UICore.height
	* @description Returns height of ui, in pixels.
	* @usage       <code>UICore.height:Number;</code>
	*
	* @return	Number; height of ui, in pixels.
	*/
	public function get height() : Number
	{
		return getUI()._height;
	};	
	
	
	/**
	* @method      UICore.x
	* @description Sets the x coordinate of ui, in pixels.
	* @usage       <code>UICore.x:Number;</code>
	*/
	public function set x( __x:Number ) 
	{
		getUI()._x = __x;
	};
	
	/**
	* @method      UICore.x
	* @description Gets the x coordinate of ui, in pixels.
	* @usage       <code>UICore.x:Number;</code>
	*/
	public function get x() : Number 
	{
		return getUI()._x
	};
	
	/**
	* @method      UICore.y
	* @description Sets the y coordinate of ui, in pixels.
	* @usage       <code>UICore.y:Number;</code>
	*/
	public function set y( __y:Number ) 
	{
		getUI()._y = __y;
	};
	
	/**
	* @method      UICore.y
	* @description Gets the y coordinate of ui, in pixels.
	* @usage       <code>UICore.y:Number;</code>
	*/
	public function get y() : Number 
	{
		return getUI()._y
	};
	
	/**
	* @method      UICore.setValue
	* @description Sets the value of UICore.
	* @usage       <code>UICore.setValue(val);</code>
	*/
	public function setValue( val ) 
	{
		_value = val;
	};
	
	/**
	* @method      UICore.getValue
	* @description Gets the value of UICore.
	* @usage       <code>UICore.getValue();</code>
	*/
	public function getValue() 
	{
		return _value;
	};
	
	/**
	* @method      UICore.setLabel
	* @description Sets the label value of UICore.
	* @usage       <code>UICore.setLabel(val:String);</code>
	*/
	public function setLabel( val:String ) 
	{
		label = val;
	};
	
	/**
	* @method      UICore.getLabel
	* @description Gets the label value of UICore.
	* @usage       <code>UICore.getLabel():String;</code>
	*/
	public function getLabel() : String
	{
		return label;
	};
	

	/**
	* @method      UICore.setReference
	* @description Sets reference to element.
	* @usage       <code>UICore.setReference(ref):Void;</code> 
	*
	* @return	reference to object element.
	*/
	public function setReference(ref) : Void
	{
		_srefrence = ref?ref:ComponentExpert.referenceExpert++;
	};
	
	/**
	* @method      UICore.getReference
	* @description Return reference to element.
	* @usage       <code>UICore.getReference();</code> 
	*
	* @return	reference to element.
	*/
	public function getReference()
	{
		return _srefrence;
	};
	
	/**
	* @method      UICore.setParent
	* @description Sets reference to the parent.
	* @usage       <code>UICore.setParent(p:UICore):Void;</code> 
	*/
	public function setParent( p:UICore ) : Void
	{
		setContainer( p.ui? p.ui : null);
		super.setParent( p );
	};

	
	/**
	* @method      UICore.setContainer
	* @description Sets reference to the parent container.
	* @usage       <code>UICore.setContainer(p:MovieClip):Void;</code> 
	*
	* @return	reference to movieclip element.
	*/
	public function setContainer(p:Object)
	{
		container = p.childs?p.childs:p;
	};
	
	/**
	* @method      UICore.getContainer
	* @description Return reference to movieclip element.
	* @usage       <code>UICore.getContainer():MovieClip;</code> 
	*
	* @return	reference to movieclip element.
	*/
	public function getContainer() : MovieClip
	{
		return container;
	};
	
	/**
	* @method      UICore.setSkin
	* @description Set reference to the skin.
	* @usage       <code>UICore.setSkin(o:ISkin):Void;</code> 
	*
	*/
	public function setSkin( o:ISkin ) : Void
	{
		_skin = o;
	};
	
	/**
	* @method      UICore.getSkin
	* @description Get reference to the skin.
	* @usage       <code>UICore.getSkin():ISkin;</code> 
	*
	*/
	public function getSkin() : ISkin
	{
		return _skin;
	};
	
	/**
	* @method      UICore.setStyle
	* @description Set reference to the style.
	* @usage       <code>UICore.setStyle(o:Style):Void;</code> 
	*
	*/
	public function setStyle( o:Style ) : Void 
	{
		_ostyle = o;
	};
	
	/**
	* @method      UICore.getStyle
	* @description Get reference to the style.
	* @usage       <code>UICore.getStyle():Style;</code> 
	*
	*/
	public function getStyle() : Style
	{
		return _ostyle;
	};

	/**
	* @method      UICore.setOrient
	* @description Sets the orientation of UI.
	* @usage       <code>UIContainer.setOrientation(val:String);</code>
	*/
	public function setOrient( val:String ) 
	{
		_sorient = val;
	};
	
	/**
	* @method      UICore.getOrient
	* @description gets the orientation of UI.
	* @usage       <code>UIContainer.getOrientation():String;</code>
	*/
	public function getOrient( ) : String 
	{
		return _sorient;
	};
	
	/**
	* @method      UICore.setDir
	* @description Sets the direction of UI.
	* @usage       <code>UIContainer.setDir(val:String);</code>
	*/
	public function setDir( val:String ) 
	{
		_sdirection = val;
	};
	
	/**
	* @method      UICore.getDir
	* @description gets the direction of UI.
	* @usage       <code>UIContainer.getDir():String;</code>
	*/
	public function getDir( ) : String 
	{
		return _sdirection;
	};
	

	/**
	* @method      UICore.setUI
	* @description Set reference to movieclip element.
	* @usage       <code>UICore.setUI(_ui:MovieClip):Void;</code> 
	*
	*/	
	public function setUI( _ui:MovieClip ) 
	{
		ui = ( _ui!=null )?_ui:null;
		if( ui!=null ) {
			setContainer( ui._parent );
			
			init();
			setup();
			create();
			needrefresh = false;
		}
	};	
	
	/**
	* @method      UICore.getUI
	* @description Return reference to movieclip element.
	* @usage       <code>UICore.getUI(_show:Boolean):MovieClip;</code> 
	*
	*/
	public function getUI( _show:Boolean ) : MovieClip
	{
		if( ui==null || ui==undefined ) {
			setup( );			
		};
		if( _show ) paint( ui );
		return ui;		
	};
	
	/**
	* @method      UICore.setPosition
	* @description Sets the x,y coordinates of ui, in pixels.
	* @usage       <code>UICore.setPosition(x:Number, y:Number):Void;</code>
	*/
	public function setPosition(__x:Number, __y:Number) : Void
	{
		x = __x;
		y = __y;
	};

	/**
	* @method      UICore.setSize
	* @description Sets the width,height properties of ui, in pixels.
	* @usage       <code>UICore.setSize(w:Number, h:Number):Void;</code>
	*/
	public function setSize(w:Number, h:Number) : Void
	{
		width  = w;
		height = h;
	};
	
	/**
	* @method      UICore.getNextDepth
	* @description Returns depth in the ui container.
	* @usage       <code>UICore.getNextDepth():Number;</code> 
	*
	* @return	Number; depth of the ui container.
	*/
	public function getNextDepth() : Number
	{
		return container.getNextHighestDepth();
	};
	
	
	/**
	* @method      UICore.paint
	* @description Paints skin into ui.
	* @usage       <code>UICore.paint():Void;</code> 
	*
	*/
	public function paint( ) : Void
	{		
		_skin.draw( ui, width, height, getStyle() );
	};
	
	/**
	* @method      UICore.create
	* @description Start building ui.
	* @usage       <code>UICore.create():Void;</code> 
	*
	*/	
	public function create() : Void 
	{	
		if( needrefresh ) {				
			refresh();
		};			
		getUI( true );	
	};
	
	/**
	* @method      UICore.refresh
	* @description Rebuilds ui.
	* @usage       <code>UICore.refresh():Void;</code> 
	*
	*/	
	public function refresh() : Void 
	{		
		if( needrefresh ) {
			if( getParent() && container==null ) {
				setContainer( UICore( getParent() ).ui );
			}
			setup( );	
		}	
		UICore( getParent() ).refresh();		
	};
	
	/**
	* @method      UICore.clear
	* @description Removes UICore movieclip.
	* @usage       <code>UICore.clear():Void;</code> 
	*/
	public function clear( ) : Void
	{
		removeAllListeners();
		ui.removeMovieClip();
		needrefresh = true;
		container=null;
		ui=null;
	};	
	
	/**
	* @method      UICore.destroy
	* @description Destroys this UICore instance.
	* @usage       <code>UICore.destroy():Void;</code> 
	*/
	public function destroy() : Void
	{
		clear( );				
		_oEB.empty();
		delete this;		
	};
	
	/**
	* @method      UICore.toString
	* @description Returns string description of UICore instance.
	* @usage       <code>UICore.toString():String;</code> 
	*/
	public function toString() : String 
	{
		return PixlibStringifier.stringify(this) + ": " + getReference();
	};


	/**
	* @method	   UICoreprivate constructor
	* @usage       <code>extend</code> 
	*/
	private function UICore( _styleID ) 
	{		
		// mg
		UICore.initStyleInstance = Theme.initialize();
		
		_getStyleInstance( _styleID );
		init( );
	};
	
	private function _getStyleInstance( _styleID ) : Void
	{
		// mg
		var style:Style;
		
		if( _styleID instanceof Style )
			style = _styleID;
		else if( typeof(_styleID) == "string" ) {
			if( _styleID.indexOf(".") != -1 && _styleID.indexOf(";") == -1 ) {
				style = Style.getStyle( _styleID.split(".")[0] ).getSubStyle( _styleID.split(".")[1] );
			} else if( _styleID.indexOf(";") == -1 ) {				
				style = Style.getStyle( _styleID );
			} else style = Style.getStyle( styleClass );
		}		
		else style = Style.getStyle( styleClass );
	
		setStyle(  Style.cloneStyle( style ) );	
		setSkin( UICore.UISKIN );	
	};
	
	private function setup( ) : Void
	{
		if (container == null || container == undefined) { /**/ }
		else if (ui != null ) { /**/ }
		else {			
			ui = _skin.init( container, getNextDepth(), getStyle().skin?getStyle().skin:styleClass );
			ui.tabChildren = false;
			needrefresh = false;
		};
	};
	
	private function init( ) : Void
	{	
		//
	};
	
	private var needrefresh:Boolean = true;	
	private var _skin:ISkin = null;		
	
	
	private var _value;		
	private var _ostyle:Style = null;	
	private var _sorient:String = null;
	private var _srefrence:String = null;
	private var _sdirection:String = null;
	

}