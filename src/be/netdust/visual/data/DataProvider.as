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
import com.bourre.events.EventBroadcaster;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
import com.bourre.events.IEvent;

class be.netdust.visual.data.DataProvider
{
	private var _data:Array;
	private var _current:Number = 0;
	private var _oEB : EventBroadcaster;	
	
	public function DataProvider( ) {
		_data = new Array();
		_oEB = new EventBroadcaster( this );
	};

	/**
	* @method      DataProvider.dispatchType
	* @description dispatchs an BasicEvent to listener.
	* @usage       <code>DataProvider.dispatchType(e:String);</code>
	*/		
	public function dispatchType(e:String) : Void {
		_oEB.broadcastEvent( new BasicEvent( new EventType( e ) ) )
	};	
	
	/**
	* @method      DataProvider.addListener
	* @description adds a listener to DataProvider dispatcher.
	* @usage       <code>DataProvider.addListener( oL );</code>
	*/	
	public function addListener( oL ) : Void {
        _oEB.addListener(oL);
    }
	
 	/**
	* @method      DataProvider.removeListener
	* @description removes a listener from DataProvider dispatcher.
	* @usage       <code>DataProvider.removeListener( oL );</code>
	*/	   
    public function removeListener( oL ) : Void {
        _oEB.removeListener( oL );
    }
    
 	/**
	* @method      DataProvider.removeAllListeners
	* @description removes all listeners from DataProvider dispatcher.
	* @usage       <code>DataProvider.removeAllListeners(  );</code>
	*/	  
	public function removeAllListeners() {
		_oEB.removeAllListeners();
	};
	
	/**
	* @method      DataProvider.getData
	* @description Returns DataProvider's data.
	* @usage       <code>DataProvider.getData( ):Array;</code>
	*
	* @return   Array; data array.
	*/
	public function getData( ):Array {
		return _data;
	};	
	
	/**
	* @method      DataProvider.getItem
	* @description Returns current item.
	* @usage       <code>DataProvider.getItem( ):Object;</code>
	*
	* @return   Object; data object.
	*/
	public function getItem( ):Object {
		return _data[_current];
	};
	
	
	/**
	* @method      DataProvider.getIndex
	* @description Returns index of required object.
	* @usage       <code>DataProvider.getIndex(o):Number;</code>
	*
	* @param    o () object. 
	* @return   Number; index of .
	*/
	public function getIndex( o ):Number {
		var i:Number = _data.length;
		while(i--) {
			if (_data[i] == o ) return i;
		}
		return -1;
	};

	/**
	* @method      DataProvider.getItemAt
	* @description returns the item on specified index.
	* @usage       <code>DataProvider.getItemAt( ):Object;</code>
	*
	* @return   Object; data object.
	*/
	public function getItemAt( index ):Object {
		return _data[index];
	};

	/**
	* @method      DataProvider.addItem
	* @description adds and returns the new item.
	* @usage       <code>DataProvider.addItem( ):Object;</code>
	*
	* @return   Object; new data object.
	*/
	public function addItem( o ):Object {
		return addItemAt( 0, o );
	};
	
	/**
	* @method      DataProvider.addItemAt
	* @description Returns dataobject at specified position.
	* @usage       <code>DataProvider.addItemAt(index:Number):Object;</code>
	*
	* @param    index   (Number) serial number of item.
	* @return   Object; data object.
	*/
	public function addItemAt(index:Number, o):Object {
		if (index > _data.length) {
			_data.push(o);
		} else if (index > -1) {
			_data.splice(index, 0, o);
		}
		
		dispatchType("onModelChanged");
		return _data[index];
	};
	
	/**
	* @method      DataProvider.removeItem
	* @description removes and returns the item.
	* @usage       <code>DataProvider.removeItem( ):Object;</code>
	*
	* @return   Object; removed data object.
	*/
	public function removeItem( o ) {
		var i:Number = _data.length;
		var dob;
		while(i--) {
			if (_data[i] == o) {
				dob =  _data.splice(i,1)[0];	
			}
		}
		
		dispatchType("onModelChanged");
		return dob;
	};
	
	/**
	* @method      DataProvider.removeItemAt
	* @description Removes and Returns dataobject at specified position.
	* @usage       <code>DataProvider.removeItemAt(index:Number):Object;</code>
	*
	* @param    index   (Number) serial number of item.
	* @return   Object; data object.
	*/
	public function removeItemAt(index:Number):Object {
		var dob;
		if (index == 0){
			dob = _data.shift();
		} else if (index == (_data.length - 1)){
			dob = _data.pop();
		} else if(index > 0 && index < (_data.length - 1)){
			dob = _data.splice(index, 1)[0];
		} 

		dispatchType("onModelChanged");
		return dob;
	};

	
	/**
	* @method      DataProvider.sortItemsBy
	* @description Returns contents of required property.
	* @usage       <code>DataProvider.sortItemsBy(fieldName:String, order);</code>
	*
	* @param 		fieldName the field (or array of fieldNames) upon which to sort
	* @param 		order either "asc" or "desc", or the options accepted by Array.sort
	*/
	
	public function sortItemsBy(fieldName:String, order) : Void {
		if (typeof(order)=="string") {
			_data.sortOn(fieldName);
			if (order.toUpperCase()=="DESC") {
				_data.reverse();
			}
		} else {
			_data.sortOn(fieldName, order);
		}
		
		dispatchType("onSort");
	};
	
	/**
	* @method      DataProvider.next
	* @description Transition to the following item.
	* @usage       <code>DataProvider.next():Number;</code>
	*
	* @return   Number; the following item index.
	*/
	public function next():Number {
		_current++;
		if(_current >= _data.length){
			_current = 0;
		}
		
		return _current;
	};
	
	/**
	* @method      DataProvider.hasNext
	* @description Checks if next item is available in provindexer.
	* @usage       <code>DataProvider.hasNext():Boolean;</code>
	*
	* @return boolean; 
	*/		
	public function hasNext():Boolean {
		return ( _data[_current+1] == undefined );
	};
	
	/**
	* @method      DataProvider.current
	* @description Sets serial number of the current item.
	* @usage       <code>DataProvider.current(index:Number):Void;</code>
	*
	* @param    index   (Number) serial number of item.
	*/
	public function set current(index:Number):Void {
		_current = index;
	};
	
	/**
	* @method      DataProvider.length
	* @description Returns amount of items.
	* @usage       <code>DataProvider.length():Number;</code>
	*
	* @return   Number; amount of items.
	*/
	public function get length():Number {
		return _data.length;
	};
	
	
	public function toString():String {
		return "DataProvider: ";
	};

}