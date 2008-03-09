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
import be.netdust.visual.object.TextBox;
import com.bourre.log.PixlibStringifier;
import com.bourre.data.collections.Map;
import com.bourre.commands.CommandMS;
import com.bourre.commands.Delegate;

import be.netdust.visual.managers.FocusManager;
import be.netdust.visual.managers.IKey;

class be.netdust.visual.managers.KeyManager
{
	private static var _oI:KeyManager = null;
	public static function getInstance() : KeyManager
	{
		if( _oI == null ) _oI = new KeyManager();
		return _oI;
	}
	
	private function KeyManager (  ) 
	{
		_keyMap = new Map();		
		Key.addListener(this);		
	};
	
	public function release () : Void 
	{
		Key.removeListener(this);
		_keyMap.clear();
		_oI = null;
	};
	
	public function addElement ( _element:IKey, _key:String ) : Boolean 
	{
		if (_element == undefined) return false;
		if ( !_keyMap.containsKey( _key ) ) 
		{
			_keyMap.put( _key, _element );
			return true;
		} 
		
		return false;
	};
	
	public function removeElement( _element:IKey )
	{
		_keyMap.remove( _element );
	}
	
	public function toString() : String {
		return PixlibStringifier.stringify( this );
	};

	private function onKeyUp () : Void 
	{
		//if( !(FocusManager.getFocusManager().currentItem instanceof TextBox ) )
		//{
			var _elm:IKey = _keyMap.get( String.fromCharCode( Key.getAscii() ) );
			_elm.onKeyUp();
		//}
	};
	
	private function onKeyDown () : Void 
	{
		//if( !(FocusManager.getFocusManager().currentItem instanceof TextBox ) )
		//{
			var _elm:IKey = _keyMap.get( String.fromCharCode( Key.getAscii() ) );
			_elm.onKeyDown();
		//}
	};


	
	private var _oOwner:IKey;
	private var _keyMap:Map;

}