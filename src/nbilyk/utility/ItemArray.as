/*
	ItemArray class
	Description:
		An extention of the Array class, added functionality includes removeItem() and binarySearch()
		Even though it is possible,  do not add elements to the array by direct assignment.  Use addItem(item_obj, index) so the added items will be assigned the IDs that are used in searching.
		Usage: 
	Constructor: (see Array class)	
	Properties:
		blockSize
			Description: Keep as a multiple of 2. Make this a smaller number for larger arrays that don't change order frequently
	Functions: 
		(most functions are the same, but add a unique order tag to objects that are added to the array. 
		addItem(item_obj, index:Number)
			Description: adds an item to the array at [index].
		removeItem(item_obj:Object)
			Description: Removes [item_obj] from the array.
			Returns: index of removed item.
		removeItemAt(index:Number)
			Description: Removes the item at [index].
		binarySearch(item_obj)
			Description: returns the index where [item_obj] is.
		swap(indexA, indexB)
			Description: swaps element at [indexA] with the element at [indexB]
	
*/
import nbilyk.utility.Search;

class nbilyk.utility.ItemArray extends Array {
	public var className:String = "ItemArray";
	private var indexCount:Number = 0;
	private var __uniqueTag:String;
	public var blockSize:Number = 128; 
	
	public function ItemArray() {
		super();
		var l = arguments.length;
		if (l == 1) {
			this.push(arguments[0]);			
		} else {
			for (var i=0; i<l; i++) {
				this.push(arguments[i]);
			}
		}
		if (!_global.uniqueID) _global.uniqueID = 0;
		_global.uniqueID %= 10000;
		this.__uniqueTag = "listenerID"+(++_global.uniqueID);
	}
	public function unshift() {
		var numArgs = arguments.length;
		for (var i=0; i<numArgs; i++) {
			this.addItem(arguments[i], i);
		}
	}
	public function push(item_obj) {
		var l = arguments.length;
		for (var i=0; i<l; i++) {
			this.addItem(arguments[i]);
		}
	}
	public function shift():Object {
		this[0][this.__uniqueTag] = undefined;
		return super.shift();
	}

	public function addItem(item_obj, index) {
		var dirty = false;
		if (index == undefined) {
			index = this.length;
		}
		if (this.contains(item_obj)) return; // Don't add the same item twice in an ItemArray.
		// Convert simple types to objects.
		if (typeof(item_obj) == "number") {
			item_obj = new Number(item_obj);
		} else if (typeof(item_obj) == "boolean") {
			item_obj = new Boolean(item_obj);
		} else if (typeof(item_obj) == "string") {
			item_obj = new String(item_obj);
		}
		if (index == this.length) {
			this.indexCount += this.blockSize;
			item_obj[this.__uniqueTag] = this.indexCount;
		} else {
			// new item is in between two items, keep the unique tag index in order.
			var a, b;
			if (index == 0) a = 0;
			else a = this[index-1][this.__uniqueTag];
			b = this[index][this.__uniqueTag];
			var h:Number = (b - a >> 1);
			item_obj[this.__uniqueTag] = a + h;
			if (h == 0) dirty = true;
		}
		if (this.indexCount > 1000000) dirty = true;;
		this.splice(index, 0, item_obj);
		if (dirty) this.cleanUp();
	}
	public function removeItem(item_obj):Number {
		var index = this.getIndex(item_obj);
		if (index != undefined) { 
			this[index][this.__uniqueTag] = undefined;
			this.splice(index, 1);
		}
		return index;
	}	
	public function removeItemAt(index):Object {
		return this.splice(index, 1)[0];
	}
	private function cleanUp() {
		var c = 0;
		var l = this.length;
		for (var i=0; i<l; i++) {
			c += this.blockSize;
			this[i][this.__uniqueTag] = c;
		}
	}	
	public function swap(indexA, indexB) {
		var temp = this[indexA];
		this[indexA] = this[indexB];
		this[indexB] = temp;
		temp = this[indexA][this.__uniqueTag];
		this[indexA][this.__uniqueTag] = this[indexB][this.__uniqueTag];
		this[indexB][this.__uniqueTag] = temp;
	}
	public function deflate() {
		// Removes all undefined objects.
		var l = this.length;
		for (var i=0; i<l; i++) {
			if (this[i] == undefined) this.splice(i, 1);			
		}
	}
	public function getIndex(item_obj):Number {
		if (this.contains(item_obj)) {
			return Search.quickSearch(this, item_obj[this.__uniqueTag], this.__uniqueTag);
		} else {
			return undefined;
		}
	}
	public function contains(item_obj) {
		return (item_obj[this.__uniqueTag] != undefined);
	}
}