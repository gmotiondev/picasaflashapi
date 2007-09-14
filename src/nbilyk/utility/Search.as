class nbilyk.utility.Search
{	
	static function binarySearch(arr:Array, val:Number, min:Number, max:Number):Number {
		// Returns the index of the ordered array where val would belong.
		if (min == undefined) min = 0;
		if (max == undefined) max = arr.length;
		if (max - min <= 0) return min;
		var mid = (max+min) >> 1;
		if (val > arr[mid]) {
			return binarySearch(arr, val, mid+1, max);
		} else {
			return binarySearch(arr, val, min, mid);
		}
	}
	public static function quickSearch(arr:Array, val:Number, propertyName:String):Number {
		// Finds the index of the ordered array where val is.  If val is not in the array, returns undefined.
		var min = 0;
		var max = arr.length-1;	
		if (propertyName == undefined) return quickSearch_intArr(arr, val, min, max);
		else return quickSearch_objArr(arr, val, propertyName, min, max);
	}
	private static function quickSearch_intArr(arr:Array, val:Number, min:Number, max:Number):Number {
		// Does a binary search until the search window is 4 or less, then does a linear search.
		var range = max-min;
		if (range < 4) {			
			for (var i=min; i<=max; i++) {
				if (arr[i] == val) {
					return i;
				}
			}
			return undefined;
		}
		var mid = (range >> 1) + min;
		if (val <= arr[mid]) {
			return Search.quickSearch_intArr(arr, val, min, mid);
		} else {
			return Search.quickSearch_intArr(arr, val, mid+1, max);
		}
	}
	private static function quickSearch_objArr(arr:Array, val:Number, propertyName:String, min:Number, max:Number):Number {
		// Does a binary search until the search window is 4 or less, then does a linear search.		
		var range = max-min;
		if (range < 4) {
			for (var i=min; i<=max; i++) {
				if (arr[i][propertyName] == val) {					
					return i;
				}
			}
			return undefined;
		}
		var mid = (range >> 1) + min;
		if (val <= arr[mid][propertyName]) {
			return Search.quickSearch_objArr(arr, val, propertyName, min, mid);
		} else {
			return Search.quickSearch_objArr(arr, val, propertyName, mid+1, max);
		}
	}
	public static function linearSearch(arr:Array, val:Object, propertyName:String):Number {
		// Does a linear search on arr for val.  If propertyName is given, arr is assumed to be an array of objects with a property [propertyName]
		var len = arr.length;
		if (propertyName == undefined) {
			for (var i=0; i<len; i++) {
				if (arr[i] == val) return i;
			}
		} else {
			for (var i=0; i<len; i++) {
				if (arr[i][propertyName] == val) return i;
			}
		}
		return undefined;
	}
}