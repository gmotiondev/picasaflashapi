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
import com.bourre.data.collections.IndexedList;
import com.bourre.data.collections.Map;
import com.bourre.log.PixlibStringifier;

import be.netdust.visual.managers.IFocus;
import be.netdust.visual.managers.ITabGroup;
class be.netdust.visual.managers.FocusManager
{
	private static var _oFocusM:Map = new Map();
	private static var _sID:String = null;
	
	public static function getInstance( _sID:String, _group:ITabGroup) : FocusManager
	{
		if( !FocusManager.isRegistered( _sID ) )
		{
			FocusManager._sID = _sID
			return FocusManager.registerFocusManager( new FocusManager( _sID, _group ) );
		};
		
		return null;
	}
	
	public static function getFocusManager() : FocusManager
	{
		return FocusManager._oFocusM.get( FocusManager._sID )
	}
	
	public static function isRegistered( _sID:String ) : Boolean
	{
		return FocusManager._oFocusM.containsKey( _sID )
	}
	
	private static function registerFocusManager( _oFM:FocusManager ) : FocusManager
	{
		FocusManager._oFocusM.put( _oFM._sName, _oFM );
		return _oFM;
	}
	
	public var currentItem:IFocus = null;
	
	private function FocusManager( _sID:String, _group :ITabGroup ) 
	{
		clear();	
		_sName = _sID;
		_oOwner = _group;

		Key.addListener(this);		
	};
	
	public function elementRecievedfocus( _oFocus:IFocus )
	{
		FocusManager._sID = _sName;
		currentItem = _oFocus;
	}
	
	public function registerElement( _oFocus:IFocus )
	{
		if( !_lFoc.objectExists( _oFocus ) )
		_lFoc.push( _oFocus );
	}
	
	public function removeElement( _oFocus:IFocus )
	{
		_lFoc.remove( _oFocus );
	}
	
	public function clear () : Void 
	{		
		currentItem = null;		
		_lFoc = new IndexedList();
	};
	
	public function release () : Void 
	{
		clear ();
		Key.removeListener(this);
	};
	
	public function setFocus ( _oFocus:IFocus ) : Void
	{
		changeFocus( currentItem, _oFocus );		
	};
	
	public function toString() : String 
	{
		return PixlibStringifier.stringify(this);
	};

	
	private function onKeyUp () : Void 
	{
		if ( Key.getCode() == Key.TAB && FocusManager._sID == _sName ) {
			if (Key.isDown(Key.SHIFT)) {
				prevFocus();
			} else {
				nextFocus();
			}
		}
	};	
	
	private function nextFocus () : Void 
	{
		var _aFocus:Array = _lFoc.getElements();
		var index:Number = getIndex( currentItem );

		if( _aFocus[ index-1 ] != undefined )
		changeFocus( currentItem, _aFocus[ index-1 ] );
		else {
			changeFocus( currentItem, _aFocus[ _aFocus.length-1 ] );
		}
	};

	private function prevFocus () : Void 
	{
		var _aFocus:Array = _lFoc.getElements();
		var index:Number = getIndex( currentItem );
		
		if( _aFocus[ index+1 ] != undefined )
		changeFocus( currentItem, _aFocus[ index+1 ] );
		else {
			changeFocus( currentItem, _aFocus[ _aFocus.length-1 ] );
		}
	};
	
	private function getIndex( _oFocus:IFocus ) : Number 
	{
		var _aFocus:Array = _lFoc.getElements();
		while( _aFocus.length )
		{
			if( _oFocus == _aFocus.pop() )
			{
				return _aFocus.length;
			}
			
		}
	}
	private function changeFocus ( _current:IFocus, _next:IFocus ) : Void 
	{
		currentItem = _next;
		
		_next.setFocus();
		_current.killFocus();
	};

	
	private var _sName:String = null;
	private var _lFoc:IndexedList = null;
	private var _oOwner:ITabGroup = null;	

}