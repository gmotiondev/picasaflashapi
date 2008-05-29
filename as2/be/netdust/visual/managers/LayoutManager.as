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

import be.netdust.visual.UIContainer;
import be.netdust.visual.UICore;
class be.netdust.visual.managers.LayoutManager 
{
	public var contentwidth:Number;
	public var contentheight:Number;	
	
	/**
	* Constructor
	* @param	_dir 	direction the layout flows
	* @param	_owner	owner of the layoutmanager
	*/
	public function LayoutManager( _dir:String, _owner:UIContainer ) 
	{
		setOwner( _owner );
		setDirection( _dir );		
	};
	
	/**
	* @method      LayoutManager.setDirection
	* @description Sets the direction of the layoutmanager.
	* @usage       <code>LayoutManager.setDirection( _dir:String ):Void;</code> 
	*/
	public function setDirection( _dir:String ) : Void
	{
		_direction = _dir;
	};
	
	/**
	* @method      LayoutManager.getDirection
	* @description Gets the direction of the layoutmanager.
	* @usage       <code>LayoutManager.getDirection( ):String;</code> 
	*/
	public function getDirection(  ) : String
	{
		return _direction;
	};
	
	/**
	* @method      LayoutManager.setOwner
	* @description Sets the owner of the layoutmanager.
	* @usage       <code>LayoutManager.setOwner( _owner:UIContainer ):Void;</code> 
	*/
	public function setOwner( _owner:UIContainer ) : Void
	{
		_oOwner = _owner
	};
	
	/**
	* @method      LayoutManager.getOwner
	* @description Gets the owner of the layoutmanager.
	* @usage       <code>LayoutManager.getOwner( ):UIContainer;</code> 
	*/
	public function getOwner(  ) : UIContainer
	{
		return _oOwner;
	};
	
	/**
	* @method      LayoutManager.reset
	* @description Resets the layoutmanager to original value.
	* @usage       <code>LayoutManager.reset( ):Void;</code> 
	*/
	public function reset( ) : Void
	{				
		_styleformat =  _oOwner.getStyle();	
		contentheight = contentwidth = 0;
		stepX = posY = 0;	
		stepY = posX = 0; 
	};
	
	/**
	* @method      LayoutManager.doAlign()
	* @description Public method for aligning elements of container in opposite direction.
	* @usage       <code>LayoutManager.doAlign():Void;</code> 
	*/	
	public function doAlign() : Void
	{
		var l:Number = -1
		var childs:Array =  _oOwner.childs;
		while( l < childs.length-1 ) {
			var _ui:UICore = childs[++l];	
			align( _oOwner.getAlign(), _ui );
		};	
		
		doPack();
	};

	/**
	* @method      LayoutManager.doPack()
	* @description Public method for aligning elements of container in same direction.
	* @usage       <code>LayoutManager.doPack():Void;</code> 
	*/	
	public function doPack() : Void
	{
		var l:Number = -1
		var childs:Array =  _oOwner.childs;
		while( l < childs.length-1 ) {
			var _ui:UICore = childs[++l];	
			pack( _oOwner.getPack(), _ui );
			
		};	
	};
	
	/**
	* @method      LayoutManager.getSize
	* @description calculates contianers dimensions.
	* @usage       <code>LayoutManager.getSize( ):Void;</code> 
	*/
	public function getSize( ) : Void
	{
		var l:Number = -1
		var childs:Array =  _oOwner.childs;
		var width:Number;
		var height:Number;
		
		while( l < childs.length-1 ) 
		{
			var _ui:UICore = childs[++l];	
			
			var w:Number = _ui.x + _ui.width + _ui.getStyle().marginRight;
			var h:Number = _ui.y + _ui.height + _ui.getStyle().marginBottom;	
			
			contentwidth = contentwidth<w ? w : contentwidth;
			contentheight = contentheight<h ? h :contentheight;
			
			width = contentwidth + ( _oOwner.getStyle().hpadding + _oOwner.getStyle().hborder );
			height = contentheight + ( _oOwner.getStyle().vpadding + _oOwner.getStyle().vborder );	
		};
		_oOwner.setSize( width, height );
	};

	/**
	* @method      LayoutManager.position
	* @description Places elements in UIContainer.
	* @usage       <code>LayoutManager.position( _child:UICore ):Void;</code> 
	*/
	public function position( _child:UICore ) : Void 
	{	
		setPosition( _child );
		(_direction == "horizontal") ? horizontalStep( _child ) : verticalStep( _child );
	};
	
	public function toString() : String
	{
		return PixlibStringifier.stringify( this );
	}
	
	/**
	* @method      LayoutManager.align
	* @description Aligns element in container.
	* @usage       <code>LayoutManager.align( _align:String, _child:UICore ):Void;</code> 
	*/
	private function align( _align:String, _child:UICore ) : Void 
	{
		if( _direction == "horizontal" ) { 
			switch ( _align ) {
				case "center" :
					_child.setPosition( _child.x, Math.round( ( UIContainer( _child.getParent() ).getContentHeight()/2) - (_child.height/2) )  );
					break;
				case "end" :
					var childheight:Number = _child.height + _child.getStyle().marginBottom;
					_child.setPosition( _child.x, Math.round( UIContainer( _child.getParent() ).getContentHeight() - childheight ) );
					break;
			};
		}
		else if( _direction == "vertical" ) { 		
			switch ( _align ) {
				case "center" :	
					_child.setPosition( Math.round( (UIContainer( _child.getParent() ).getContentWidth()/2) - (_child.width/2) ), _child.y );
					break;
				case "end" :
					var childwidth:Number = _child.width + _child.getStyle().marginRight;
					_child.setPosition( Math.round( UIContainer( _child.getParent() ).getContentWidth() - childwidth ), _child.y );					
					break;
			}
		}
	};
	
	/**
	* @method      LayoutManager.pack
	* @description Packs element in container.
	* @usage       <code>LayoutManager.pack( _pack:String, _child:UICore ):Void;</code> 
	*/
	private function pack( _pack:String, _child:UICore ) : Void
	{		
		if( _direction == "vertical" ) { 
			switch ( _pack ) {
				case "center" :
					_child.setPosition( _child.x, Math.round( ( UIContainer( _child.getParent() ).getContentHeight()/2) - (_child.height/2) ) );
					break;
				case "end" :
					var childheight:Number = _child.height + _child.getStyle().marginTop;
					_child.setPosition( _child.x, Math.round(  UIContainer( _child.getParent() ).getContentHeight() - childheight ) );
					break;
			};
		}
		else if( _direction == "horizontal" ) { 		
			switch ( _pack ) {
				case "center" :					
					_child.setPosition( Math.round( ( UIContainer( _child.getParent() ).getContentWidth()/2) - (_child.width/2) ), _child.y );
					break;
				case "end" :
					var childwidth:Number = _child.width + _child.getStyle().marginLeft;
					_child.setPosition( Math.round(  UIContainer( _child.getParent() ).getContentWidth() - childwidth ), _child.y );	
					break;
			}
		}
	};
	

	/**
	* @method      LayoutManager.setPosition
	* @description places element in position.
	* @usage       <code>LayoutManager.setPosition( _child:UICore ):Void;</code> 
	*/
	private function setPosition( _child:UICore ) : Void
	{		
		_child.setPosition( _child.getStyle().marginLeft + posX , _child.getStyle().marginTop + posY  );
	};
	
	/**
	* @method      LayoutManager.horizontalStep
	* @description calculates next horizontal position.
	* @usage       <code>LayoutManager.horizontalStep( _child:UICore ):Void;</code> 
	*/
	private function horizontalStep( _child:UICore ) 
	{
		posX += _child.width + _child.getStyle().hmargin; 
	};
	
	/**
	* @method      LayoutManager.verticalStep
	* @description calculates next vertical position.
	* @usage       <code>LayoutManager.verticalStep( _child:UICore ):Void;</code> 
	*/
	private function verticalStep( _child:UICore ) : Void
	{	
		posY += _child.height + _child.getStyle().vmargin;
	};
	
	
	private var _oOwner:UIContainer;
	private var _styleformat:Object;
	private var _direction:String;
	
	private var stepX:Number = 0;
	private var stepY:Number = 0; 			
	private var posY:Number = 0; 	
	private var posX:Number = 0; 

}